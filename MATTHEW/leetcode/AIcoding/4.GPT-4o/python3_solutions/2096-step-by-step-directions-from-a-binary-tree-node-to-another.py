class Solution:
    def getDirections(self, root: TreeNode, startValue: int, destValue: int) -> str:
        def find_path(node, value, path):
            if not node:
                return False
            if node.val == value:
                return True

            path.append('L')
            if find_path(node.left, value, path):
                return True
            path.pop()

            path.append('R')
            if find_path(node.right, value, path):
                return True
            path.pop()

            return False

        def find_lca(node, start, dest):
            if not node:
                return None
            if node.val == start or node.val == dest:
                return node

            left = find_lca(node.left, start, dest)
            right = find_lca(node.right, start, dest)

            if left and right:
                return node
            return left if left else right

        lca = find_lca(root, startValue, destValue)

        path_to_start = []
        find_path(lca, startValue, path_to_start)
        path_to_dest = []
        find_path(lca, destValue, path_to_dest)

        return 'U' * (len(path_to_start) - 1) + ''.join(path_to_dest)