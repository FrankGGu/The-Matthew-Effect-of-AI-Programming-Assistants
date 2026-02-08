class Solution:
    def findSecondMinimumValue(self, root: Optional[TreeNode]) -> int:
        values = set()

        def traverse(node):
            if not node:
                return
            values.add(node.val)
            traverse(node.left)
            traverse(node.right)

        traverse(root)
        if len(values) < 2:
            return -1
        sorted_values = sorted(values)
        return sorted_values[1]