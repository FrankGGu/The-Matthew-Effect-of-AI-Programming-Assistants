%% Definition for isBadVersion API.
%% - The isBadVersion API is provided externally, so we'll assume it exists.
%% - In this solution, we will use binary search to minimize the number of API calls.

-spec first_bad_version(N :: integer()) -> integer().
first_bad_version(N) -> 
    first_bad_version(1, N).

-spec first_bad_version(Low :: integer(), High :: integer()) -> integer().
first_bad_version(Low, High) when Low < High ->
    Mid = (Low + High) div 2,
    case is_bad_version(Mid) of
        true -> first_bad_version(Low, Mid);  % Continue searching in the lower half
        false -> first_bad_version(Mid + 1, High)  % Continue searching in the upper half
    end;
first_bad_version(Low, High) -> Low.

%% Placeholder function for isBadVersion API. In actual use, this would be provided.
-spec is_bad_version(Version :: integer()) -> boolean().
is_bad_version(Version) -> 
    %% This is just a placeholder; in reality, this function would return whether the version is bad or not.
    false.
