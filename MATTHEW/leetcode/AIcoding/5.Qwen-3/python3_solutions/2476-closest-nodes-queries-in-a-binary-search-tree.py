class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def closestNodes(self, root: Optional[TreeNode], queries: List[int]) -> List[List[int]]:
        def inorder(node):
            if not node:
                return []
            return inorder(node.left) + [node.val] + inorder(node.right)

        sorted_vals = inorder(root)

        result = []
        for q in queries:
            left = -1
            right = -1
            l, r = 0, len(sorted_vals) - 1
            while l <= r:
                mid = (l + r) // 2
                if sorted_vals[mid] < q:
                    l = mid + 1
                else:
                    r = mid - 1
            if l < len(sorted_vals):
                right = sorted_vals[l]
            if l > 0:
                left = sorted_vals[l - 1]
            result.append([left, right])
        return result