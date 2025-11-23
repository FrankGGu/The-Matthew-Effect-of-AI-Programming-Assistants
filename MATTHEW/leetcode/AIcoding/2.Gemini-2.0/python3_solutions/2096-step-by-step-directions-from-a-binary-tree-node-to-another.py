class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def getDirections(self, root: TreeNode, startValue: int, destValue: int) -> str:
        def find_path(root, target):
            if not root:
                return None
            if root.val == target:
                return ""

            left_path = find_path(root.left, target)
            if left_path is not None:
                return "L" + left_path

            right_path = find_path(root.right, target)
            if right_path is not None:
                return "R" + right_path

            return None

        start_path = find_path(root, startValue)
        dest_path = find_path(root, destValue)

        i = 0
        while i < min(len(start_path), len(dest_path)) and start_path[i] == dest_path[i]:
            i += 1

        up_moves = "U" * (len(start_path) - i)
        down_moves = dest_path[i:]

        return up_moves + down_moves