from collections import defaultdict
import sys

class Solution:
    def loudAndRich(self, richer: list[list[int]], quiet: list[int]) -> list[int]:
        n = len(quiet)

        # adj[u] will store all people v such that v is richer than u.
        # This means u is poorer than v.
        # For richer = [[ai, bi]], ai is richer than bi. So, for bi, ai is a richer person.
        # We add ai to adj[bi].
        adj = defaultdict(list)
        for ai, bi in richer:
            adj[bi].append(ai) 

        # answer[i] will store the person with minimum quietness among all people
        # who are richer than or equal to person i.
        # Initialize answer[i] to -1 to indicate not computed.
        answer = [-1] * n 

        # Set recursion limit for potentially deep graphs.
        # N can be up to 500, default is usually 1000, so this is generally safe.
        sys.setrecursionlimit(n + 50) 

        # DFS function to find the person with minimum quietness for 'u'
        def dfs(u: int) -> int:
            # If answer[u] is not -1, it means it has already been computed.
            if answer[u] != -1:
                return answer[u]

            # Initialize the current best candidate for u as u itself.
            # This covers the "or equal to person i" part.
            current_min_quiet_person = u 

            # Explore all people 'v' who are directly richer than 'u'.
            # These are the 'parents' of 'u' in the richer hierarchy.
            for v in adj[u]:
                # Recursively find the quietest person among 'v' and its richer ancestors.
                richer_quietest_person = dfs(v)

                # Compare the quietness of the current best candidate for 'u'
                # with the quietness of the quietest person found through 'v'.
                if quiet[richer_quietest_person] < quiet[current_min_quiet_person]:
                    current_min_quiet_person = richer_quietest_person

            # Store the computed result in answer[u] before returning.
            answer[u] = current_min_quiet_person
            return current_min_quiet_person

        # Call DFS for each person to ensure all values in 'answer' are computed.
        # This handles disconnected components in the richer graph.
        for i in range(n):
            dfs(i)

        return answer