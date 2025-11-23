class Solution:
    def transportationHub(self, path: List[List[int]]) -> int:
        in_degree = {}
        out_degree = {}
        nodes = set()

        for a, b in path:
            nodes.add(a)
            nodes.add(b)
            out_degree[a] = out_degree.get(a, 0) + 1
            in_degree[b] = in_degree.get(b, 0) + 1

        n = len(nodes)
        for node in nodes:
            if in_degree.get(node, 0) == n - 1 and out_degree.get(node, 0) == 0:
                return node

        return -1