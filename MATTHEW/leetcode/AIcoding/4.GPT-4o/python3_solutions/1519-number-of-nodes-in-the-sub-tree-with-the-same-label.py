from collections import defaultdict

class Solution:
    def countSubTrees(self, n: int, edges: List[List[int]], labels: str) -> List[int]:
        graph = defaultdict(list)
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        count = [0] * n
        label_count = [defaultdict(int) for _ in range(n)]

        def dfs(node, parent):
            current_label = labels[node]
            label_count[node][current_label] += 1

            for neighbor in graph[node]:
                if neighbor != parent:
                    dfs(neighbor, node)
                    for label, cnt in label_count[neighbor].items():
                        label_count[node][label] += cnt

            count[node] = label_count[node][current_label]

        dfs(0, -1)
        return count