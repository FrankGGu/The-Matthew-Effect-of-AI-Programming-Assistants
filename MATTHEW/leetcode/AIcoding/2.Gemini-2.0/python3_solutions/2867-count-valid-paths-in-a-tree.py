from collections import defaultdict

class Solution:
    def countValidPaths(self, n: int, edges: list[list[int]]) -> int:
        primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        def dfs(node, parent, prime_node):
            count = 1
            for neighbor in adj[node]:
                if neighbor != parent and not visited[neighbor]:
                    visited[neighbor] = True
                    if neighbor in primes:
                        prime_node[0] += dfs(neighbor, node, [0])
                    else:
                        count += dfs(neighbor, node, [0])
            return count

        ans = 0
        for i in range(1, n + 1):
            if i in primes:
                continue
            visited = [False] * (n + 1)
            visited[i] = True
            for neighbor in adj[i]:
                if not visited[neighbor]:
                    visited[neighbor] = True
                    prime_count = [0]
                    if neighbor in primes:
                        prime_count[0] = dfs(neighbor, i, [0])
                        ans += prime_count[0] + 1
                    else:
                        count = dfs(neighbor, i, prime_count)
                        ans += count + prime_count[0] + count * prime_count[0]

        return ans