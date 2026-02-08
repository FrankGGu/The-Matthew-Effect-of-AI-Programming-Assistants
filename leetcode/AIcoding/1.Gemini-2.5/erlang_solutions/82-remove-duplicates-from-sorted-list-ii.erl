-module(solution).
-export([deleteDuplicates/1]).

-record('ListNode', {val=0, next=undefined}).

deleteDuplicates(Head) ->
    case Head of
        undefined ->
            undefined;
        #'ListNode'{next = undefined} ->
            Head;
        #'ListNode'{val = Val, next = #'ListNode'{val = NextVal}} when Val == NextVal ->
            % Current node's value is a duplicate.
            % Skip all nodes with this duplicate value.
            SkipDuplicates = fun Skip(Node) ->
                                 case Node of
                                     undefined -> undefined;
                                     #'ListNode'{val = V} when V == Val -> Skip(Node#ListNode.next);
                                     _ -> Node
                                 end
                             end,
            NewHead = SkipDuplicates(Head#ListNode.next),
            deleteDuplicates(NewHead);
        #'ListNode'{val = Val, next = Next} ->
            % Current node's value is distinct.
            % Recursively process the rest of the list.
            NewNext = deleteDuplicates(Next),
            #'ListNode'{val = Val, next = NewNext}
    end.