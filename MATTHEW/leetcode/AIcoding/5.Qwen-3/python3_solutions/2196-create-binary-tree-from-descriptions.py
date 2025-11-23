class Solution:
    def buildBinaryTree(self, descriptions: list[list[int]]) -> Optional[TreeNode]:
        from collections import defaultdict

        nodes = {}
        children = set()

        for node, child, isLeft in descriptions:
            if node not in nodes:
                nodes[node] = TreeNode(node)
            if child not in nodes:
                nodes[child] = TreeNode(child)
            if isLeft:
                nodes[node].left = nodes[child]
            else:
                nodes[node].right = nodes[child]
            children.add(child)

        for node in nodes:
            if node not in children:
                return nodes[node]
        return None