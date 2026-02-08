class Solution:
    def validArrangement(self, pairs: List[List[int]]) -> List[List[int]]:
        graph = defaultdict(list)
        indegree = defaultdict(int)
        outdegree = defaultdict(int)

        for u, v in pairs:
            graph[u].append(v)
            outdegree[u] += 1
            indegree[v] += 1

        start_node = -1
        for node in set([u for u, _ in pairs] + [v for _, v in pairs]):
            if outdegree[node] - indegree[node] == 1:
                start_node = node
                break

        if start_node == -1:
            start_node = pairs[0][0]

        result = []
        def dfs(node):
            while graph[node]:
                neighbor = graph[node].pop()
                dfs(neighbor)
                result.append([node, neighbor])

        dfs(start_node)
        return result[::-1]