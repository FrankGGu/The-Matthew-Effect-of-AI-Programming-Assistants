import collections

class Solution:
    def longestSpecialPath(self, n: int, edges: list[list[int]], values: list[int]) -> int:
        MAX_VAL = 10**6 + 1
        is_prime = [True] * MAX_VAL
        is_prime[0] = is_prime[1] = False
        for p in range(2, int(MAX_VAL**0.5) + 1):
            if is_prime[p]:
                for multiple in range(p*p, MAX_VAL, p):
                    is_prime[multiple] = False

        adj = collections.defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        ans = 0
        has_prime_node = False
        for i in range(n):
            if is_prime[values[i]]:
                has_prime_node = True
                break

        if has_prime_node:
            ans = 1

        memo = {} # (node, forbidden_prime_val) -> longest_path_length

        def dfs(u, prev, forbidden_prime_val):
            key = (u, forbidden_prime_val)
            if key in memo:
                return memo[key]

            max_len = 1
            for v in adj[u]:
                if v != prev and is_prime[values[v]] and values[v] != forbidden_prime_val:
                    max_len = max(max_len, 1 + dfs(v, u, forbidden_prime_val))

            memo[key] = max_len
            return max_len

        for u in range(n):
            if is_prime[values[u]]:
                p = values[u] # The prime value of the current node u

                candidate_lengths = []
                for v in adj[u]:
                    # For each neighbor v, if it can be part of a valid path extension
                    if is_prime[values[v]] and values[v] != p:
                        # Find the longest path starting from v,
                        # not going back to u, and not using any node with value p
                        candidate_lengths.append(dfs(v, u, p))

                # Sort in descending order to easily pick the top two longest paths
                candidate_lengths.sort(reverse=True)

                if candidate_lengths:
                    # Case 1: Path is u -> longest_branch
                    ans = max(ans, 1 + candidate_lengths[0])
                    if len(candidate_lengths) >= 2:
                        # Case 2: Path is longest_branch_1 -> u -> longest_branch_2
                        ans = max(ans, 1 + candidate_lengths[0] + candidate_lengths[1])

        return ans