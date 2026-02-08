class Solution:
    def getDirections(self, root: Optional[TreeNode], startValue: int, destValue: int) -> str:
        def find_path(node, target, path):
            if not node:
                return False
            if node.val == target:
                return True
            if node.left and find_path(node.left, target, path):
                path.append('L')
                return True
            if node.right and find_path(node.right, target, path):
                path.append('R')
                return True
            return False

        start_path = []
        dest_path = []
        find_path(root, startValue, start_path)
        find_path(root, destValue, dest_path)
        start_path.reverse()
        dest_path.reverse()

        i = 0
        while i < len(start_path) and i < len(dest_path) and start_path[i] == dest_path[i]:
            i += 1

        result = ['U'] * (len(start_path) - i) + dest_path[i:]
        return ''.join(result)