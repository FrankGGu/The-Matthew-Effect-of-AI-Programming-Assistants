class Solution:
    def getTargetCopy(self, original: TreeNode, cloned: TreeNode, target: TreeNode) -> TreeNode:
        stack = [(original, cloned)]

        while stack:
            orig_node, clone_node = stack.pop()

            if orig_node == target:
                return clone_node

            if orig_node.left:
                stack.append((orig_node.left, clone_node.left))
            if orig_node.right:
                stack.append((orig_node.right, clone_node.right))

        return None