import sys

sys.setrecursionlimit(2 * 10**5)

class Solution:
    def rootCount(self, n: int, edges: list[list[int]], guesses: list[list[int]], k: int) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        guesses_set = set(tuple(g) for g in guesses)

        down_guesses = [0] * n

        def dfs1(u, p):
            current_down_count = 0
            for v in adj[u]:
                if v == p:
                    continue
                current_down_count += dfs1(v, u)
                if (u, v) in guesses_set:
                    current_down_count += 1
            down_guesses[u] = current_down_count
            return current_down_count

        dfs1(0, -1)

        ans = 0

        def dfs2(u, p, parent_up_guesses):
            nonlocal ans

            total_correct_for_u = down_guesses[u] + parent_up_guesses

            if total_correct_for_u >= k:
                ans += 1

            for v in adj[u]:
                if v == p:
                    continue

                new_parent_up_guesses_for_v = total_correct_for_u

                new_parent_up_guesses_for_v -= (down_guesses[v] + (1 if (u, v) in guesses_set else 0))

                new_parent_up_guesses_for_v += (1 if (v, u) in guesses_set else 0)

                dfs2(v, u, new_parent_up_guesses_for_v)

        dfs2(0, -1, 0)

        return ans