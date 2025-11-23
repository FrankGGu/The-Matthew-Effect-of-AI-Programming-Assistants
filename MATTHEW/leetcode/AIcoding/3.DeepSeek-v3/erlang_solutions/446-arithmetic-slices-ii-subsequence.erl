-spec number_of_arithmetic_slices(Nums :: [integer()]) -> integer().
number_of_arithmetic_slices(Nums) ->
    N = length(Nums),
    Ans = 0,
    DP = maps:new(),
    lists:foldl(fun(_, {AnsAcc, DPAcc}) ->
        {NewAns, NewDP} = lists:foldl(fun(J, {AnsJ, DPJ}) ->
            I = J - 1,
            Diff = lists:nth(J, Nums) - lists:nth(I, Nums),
            case maps:get({I, Diff}, DPJ, 0) of
                Count when is_integer(Count) ->
                    {AnsJ + Count, 
                     maps:put({J, Diff}, maps:get({J, Diff}, DPJ, 0) + Count + 1, DPJ)};
                _ ->
                    {AnsJ, maps:put({J, Diff}, maps:get({J, Diff}, DPJ, 0) + 1, DPJ)}
            end
        end, {0, DPAcc}, lists:seq(2, N)),
        {AnsAcc + NewAns, NewDP}
    end, {Ans, DP}, lists:seq(1, N)),
    element(1, element(1, lists:foldl(fun(_, {AnsAcc, DPAcc}) ->
        {NewAns, NewDP} = lists:foldl(fun(J, {AnsJ, DPJ}) ->
            I = J - 1,
            Diff = lists:nth(J, Nums) - lists:nth(I, Nums),
            case maps:get({I, Diff}, DPJ, 0) of
                Count when is_integer(Count) ->
                    {AnsJ + Count, 
                     maps:put({J, Diff}, maps:get({J, Diff}, DPJ, 0) + Count + 1, DPJ)};
                _ ->
                    {AnsJ, maps:put({J, Diff}, maps:get({J, Diff}, DPJ, 0) + 1, DPJ)}
            end
        end, {0, DPAcc}, lists:seq(2, N)),
        {AnsAcc + NewAns, NewDP}
    end, {Ans, DP}, lists:seq(1, N)))).