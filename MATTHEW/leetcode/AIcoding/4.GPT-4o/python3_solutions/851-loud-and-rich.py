from collections import defaultdict, deque

class Solution:
    def loudAndRich(self, richer: List[List[int]], quiet: List[int]) -> List[int]:
        graph = defaultdict(list)
        indegree = [0] * len(quiet)

        for u, v in richer:
            graph[u].append(v)
            indegree[v] += 1

        queue = deque()
        for i in range(len(quiet)):
            if indegree[i] == 0:
                queue.append(i)

        answer = list(range(len(quiet)))

        while queue:
            node = queue.popleft()
            for neighbor in graph[node]:
                if quiet[answer[node]] < quiet[answer[neighbor]]:
                    answer[neighbor] = answer[node]
                indegree[neighbor] -= 1
                if indegree[neighbor] == 0:
                    queue.append(neighbor)

        return answer