class Solution:
    def findDuplicateSubtrees(self, root: Optional[TreeNode]) -> List[Optional[TreeNode]]:
        from collections import defaultdict

        subtrees = defaultdict(int)
        result = []

        def serialize(node):
            if not node:
                return "#"
            left = serialize(node.left)
            right = serialize(node.right)
            subtree = f"{node.val},{left},{right}"
            subtrees[subtree] += 1
            if subtrees[subtree] == 2:
                result.append(node)
            return subtree

        serialize(root)
        return result