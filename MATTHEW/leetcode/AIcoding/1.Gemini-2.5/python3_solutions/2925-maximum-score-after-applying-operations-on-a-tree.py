from collections import defaultdict

class Solution:
    def maxScoreAfterOperations(self, parents: list[int], values: list[int]) -> int:
        n = len(parents)

        adj = defaultdict(list)
        for i in range(1, n):
            adj[parents[i]].append(i)

        def dfs(u: int) -> tuple[int, int]:
            # Base case: leaf node
            if not adj[u]:
                # (score if u is NOT taken, score if u IS taken)
                return (0, values[u]) 

            score_if_u_not_taken = 0
            score_if_u_taken = values[u]

            for v in adj[u]:
                child_not_taken_score, child_taken_score = dfs(v)

                # If u is not taken, we can choose to take or not take its child v.
                # We maximize by taking the better of the two options for child v's subtree.
                score_if_u_not_taken += max(child_not_taken_score, child_taken_score)

                # If u is taken, we cannot take its child v.
                # Thus, for child v's subtree, we must take the score where v is not taken.
                score_if_u_taken += child_not_taken_score

            return (score_if_u_not_taken, score_if_u_taken)

        # Start DFS from the root (node 0)
        root_not_taken_score, root_taken_score = dfs(0)

        # The maximum score is the maximum of taking the root or not taking the root
        return max(root_not_taken_score, root_taken_score)