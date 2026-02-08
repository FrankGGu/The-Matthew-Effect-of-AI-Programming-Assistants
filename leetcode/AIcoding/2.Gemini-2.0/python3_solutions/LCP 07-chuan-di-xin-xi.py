from collections import defaultdict

class Solution:
    def numWays(self, n: int, relations: List[List[int]], k: int) -> int:
        graph = defaultdict(list)
        for u, v in relations:
            graph[u].append(v)

        count = 0
        queue = [0]
        for _ in range(k):
            next_queue = []
            for u in queue:
                for v in graph[u]:
                    next_queue.append(v)
            queue = next_queue

        for node in queue:
            if node == n - 1:
                count += 1

        return count