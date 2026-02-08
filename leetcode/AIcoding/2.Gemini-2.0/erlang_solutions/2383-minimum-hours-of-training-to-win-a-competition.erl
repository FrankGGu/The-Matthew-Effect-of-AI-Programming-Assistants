-module(minimum_hours).
-export([min_number_of_hours/2]).

min_number_of_hours(initial_energy, initial_experience, energy, experience) ->
  min_number_of_hours(initial_energy, initial_experience, energy, experience, 0).

min_number_of_hours(Energy, Experience, [], [], Hours) ->
  Hours;
min_number_of_hours(Energy, Experience, [E|RestE], [X|RestX], Hours) ->
  NewEnergy =
    if Energy > E then
      Energy
    else
      Hours + E - Energy + 1,
      E + 1
    end,
  NewExperience =
    if Experience > X then
      Experience
    else
      Hours + X - Experience + 1,
      X + 1
    end,

  case {NewEnergy > Energy, NewExperience > Experience} of
    {true, true} ->
      min_number_of_hours(NewEnergy, NewExperience, RestE, RestX, Hours + max(E - Energy + 1, X - Experience + 1));
    {true, false} ->
      min_number_of_hours(NewEnergy, Experience + X, RestE, RestX, Hours + (E - Energy + 1));
    {false, true} ->
      min_number_of_hours(Energy + E, NewExperience, RestE, RestX, Hours + (X - Experience + 1));
    {false, false} ->
      min_number_of_hours(Energy + E, Experience + X, RestE, RestX, Hours)
  end.

min_number_of_hours(Energy, Experience, [E|RestE], [X|RestX], Hours) when Energy > E, Experience > X ->
  min_number_of_hours(Energy + E, Experience + X, RestE, RestX, Hours);
min_number_of_hours(Energy, Experience, [E|RestE], [X|RestX], Hours) when Energy > E ->
  min_number_of_hours(Energy + E, Experience + X, RestE, RestX, Hours);
min_number_of_hours(Energy, Experience, [E|RestE], [X|RestX], Hours) when Experience > X ->
  min_number_of_hours(Energy + E, Experience + X, RestE, RestX, Hours);
min_number_of_hours(Energy, Experience, [E|RestE], [X|RestX], Hours) ->
  NewEnergyHours = max(0, E - Energy + 1),
  NewExperienceHours = max(0, X - Experience + 1),
  NewHours = max(NewEnergyHours, NewExperienceHours),
  min_number_of_hours(Energy + E + NewEnergyHours, Experience + X + NewExperienceHours, RestE, RestX, Hours + NewHours).