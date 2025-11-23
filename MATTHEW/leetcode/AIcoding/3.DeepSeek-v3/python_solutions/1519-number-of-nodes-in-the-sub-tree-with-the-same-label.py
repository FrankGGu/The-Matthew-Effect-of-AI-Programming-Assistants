class Solution:
    def countSubTrees(self, n: int, edges: List[List[int]], labels: str) -> List[int]:
        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        res = [0] * n

        def dfs(node, parent):
            count = defaultdict(int)
            label = labels[node]
            count[label] = 1

            for child in tree[node]:
                if child == parent:
                    continue
                child_count = dfs(child, node)
                for key in child_count:
                    count[key] += child_count[key]

            res[node] = count[label]
            return count

        dfs(0, -1)
        return res