import collections

class Solution:
    def countPaths(self, n: int, edges: list[list[int]]) -> int:
        is_prime = [True] * (n + 1)
        if n >= 0:
            is_prime[0] = False
        if n >= 1:
            is_prime[1] = False
        for p in range(2, int(n**0.5) + 1):
            if is_prime[p]:
                for multiple in range(p * p, n + 1, p):
                    is_prime[multiple] = False

        adj = [[] for _ in range(n + 1)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        ans = 0

        for i in range(1, n + 1):
            if is_prime[i]:
                ans += 1  # Path consisting of the prime node itself

                connected_non_prime_counts = []

                for neighbor in adj[i]:
                    if not is_prime[neighbor]:
                        current_component_size = 0
                        q = collections.deque([neighbor])
                        temp_visited_for_this_bfs = {neighbor}

                        current_component_size += 1

                        while q:
                            curr = q.popleft()

                            for next_node in adj[curr]:
                                if not is_prime[next_node] and next_node not in temp_visited_for_this_bfs:
                                    temp_visited_for_this_bfs.add(next_node)
                                    current_component_size += 1
                                    q.append(next_node)

                        connected_non_prime_counts.append(current_component_size)

                sum_of_counts = sum(connected_non_prime_counts)
                ans += sum_of_counts

                for x in range(len(connected_non_prime_counts)):
                    for y in range(x + 1, len(connected_non_prime_counts)):
                        ans += connected_non_prime_counts[x] * connected_non_prime_counts[y]

        return ans