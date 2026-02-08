class Solution:
    def getTargetCopy(self, original: TreeNode, cloned: TreeNode, target: TreeNode) -> TreeNode:
        if not original:
            return None

        if original is target:
            return cloned

        left_result = self.getTargetCopy(original.left, cloned.left, target)
        if left_result:
            return left_result

        right_result = self.getTargetCopy(original.right, cloned.right, target)
        if right_result:
            return right_result

        return None