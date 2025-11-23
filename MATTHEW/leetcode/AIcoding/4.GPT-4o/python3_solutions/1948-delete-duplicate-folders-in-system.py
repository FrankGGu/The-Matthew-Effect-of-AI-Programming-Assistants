class Solution:
    def deleteDuplicateFolder(self, paths: List[List[str]]) -> List[List[str]]:
        from collections import defaultdict

        tree = {}
        for path in paths:
            node = tree
            for folder in path:
                if folder not in node:
                    node[folder] = {}
                node = node[folder]

        def serialize(node):
            if not node:
                return '#'
            serialized = []
            for folder in sorted(node.keys()):
                serialized.append(folder + serialize(node[folder]))
            return '(' + ''.join(serialized) + ')'

        seen = defaultdict(list)
        def dfs(node):
            serialized = serialize(node)
            seen[serialized].append(node)
            return serialized

        dfs(tree)

        result = []
        for serialized, nodes in seen.items():
            if len(nodes) == 1:
                result.append(nodes[0])

        return result