class Solution:
    def getDirections(self, root: Optional[TreeNode], startValue: int, destValue: int) -> str:

        def findLCA(node, p, q):
            if not node or node.val == p or node.val == q:
                return node

            left_lca = findLCA(node.left, p, q)
            right_lca = findLCA(node.right, p, q)

            if left_lca and right_lca:
                return node
            elif left_lca:
                return left_lca
            else:
                return right_lca

        def findPath(node, target_val, path_list):
            if not node:
                return False

            if node.val == target_val:
                return True

            path_list.append('L')
            if findPath(node.left, target_val, path_list):
                return True
            path_list.pop()

            path_list.append('R')
            if findPath(node.right, target_val, path_list):
                return True
            path_list.pop()

            return False

        lca = findLCA(root, startValue, destValue)

        path_to_start_list = []
        findPath(lca, startValue, path_to_start_list)

        path_to_dest_list = []
        findPath(lca, destValue, path_to_dest_list)

        return 'U' * len(path_to_start_list) + ''.join(path_to_dest_list)