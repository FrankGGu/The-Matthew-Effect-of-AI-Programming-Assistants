-spec number_of_steps(Num :: integer()) -> integer().
number_of_steps(Num) ->
    number_of_steps(Num, 0).

number_of_steps(0, Steps) ->
    Steps;
number_of_steps(Num, Steps) when Num rem 2 =:= 0 ->
    number_of_steps(Num div 2, Steps + 1);
number_of_steps(Num, Steps) ->
    number_of_steps(Num - 1, Steps + 1).