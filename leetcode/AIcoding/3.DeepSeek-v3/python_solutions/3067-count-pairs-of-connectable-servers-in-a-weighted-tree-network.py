class Solution:
    def countPairsOfConnectableServers(self, edges: List[List[int]], signalSpeed: int) -> List[int]:
        from collections import defaultdict

        n = len(edges) + 1
        graph = defaultdict(list)
        for u, v, w in edges:
            graph[u].append((v, w))
            graph[v].append((u, w))

        res = [0] * n

        def dfs(node, parent, distance):
            count = 0
            if distance % signalSpeed == 0:
                count += 1
            for neighbor, weight in graph[node]:
                if neighbor != parent:
                    count += dfs(neighbor, node, distance + weight)
            return count

        for i in range(n):
            total = 0
            temp = []
            for neighbor, weight in graph[i]:
                cnt = dfs(neighbor, i, weight)
                temp.append(cnt)
            sum_so_far = 0
            for num in temp:
                total += sum_so_far * num
                sum_so_far += num
            res[i] = total

        return res