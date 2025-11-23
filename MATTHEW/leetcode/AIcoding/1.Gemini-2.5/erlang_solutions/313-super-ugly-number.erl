-module(solution).
-export([nthSuperUglyNumber/2]).

nthSuperUglyNumber(N, Primes) ->
    % Initialize an array to store super ugly numbers.
    % The first super ugly number is 1.
    % We need N numbers, so the array size is N.
    % array:new(Size) creates an array of Size elements, all initialized to 'undefined'.
    UglyArray = array:new(N), 
    UglyArray1 = array:set(0, 1, UglyArray), % Set the first element to 1

    % Initialize pointers for each prime.
    % Each pointer points to an index in UglyArray.
    % Initially, all pointers point to the first ugly number (1) at index 0.
    Pointers = lists:duplicate(length(Primes), 0),

    % Iterate from the second ugly number (index 1) up to the Nth (index N-1).
    % We use a fold to build the UglyArray and update Pointers iteratively.
    % The state for the fold is {CurrentUglyArray, CurrentPointers}.
    {FinalUglyArray, _} = lists:foldl(
        fun(Index, {AccUglyArray, AccPointers}) ->
            % Calculate potential next ugly numbers for each prime.
            % For each prime P and its corresponding pointer Ptr,
            % the candidate is UglyArray[Ptr] * P.
            Candidates = calculate_candidates(AccUglyArray, AccPointers, Primes),

            % Find the minimum among these candidates. This is the next super ugly number.
            MinVal = lists:min(Candidates),

            % Store the minimum value as the next super ugly number at the current index.
            NewUglyArray = array:set(Index, MinVal, AccUglyArray),

            % Update pointers: increment the pointer for any prime that produced MinVal.
            % This handles cases where multiple primes might generate the same minimum value (e.g., 2*3 and 3*2).
            NewPointers = update_pointers(AccPointers, Candidates, MinVal),

            {NewUglyArray, NewPointers}
        end,
        {UglyArray1, Pointers},
        lists:seq(1, N - 1) % Indices from 1 to N-1
    ),

    % The Nth super ugly number is stored at index N-1 in the array.
    array:get(N - 1, FinalUglyArray).

calculate_candidates(UglyArray, Pointers, Primes) ->
    lists:zipwith(
        fun(Pointer, Prime) ->
            array:get(Pointer, UglyArray) * Prime
        end,
        Pointers,
        Primes
    ).

update_pointers(Pointers, Candidates, MinVal) ->
    lists:zipwith(
        fun(Pointer, Candidate) ->
            if Candidate == MinVal -> Pointer + 1;
               true -> Pointer
            end
        end,
        Pointers,
        Candidates
    ).