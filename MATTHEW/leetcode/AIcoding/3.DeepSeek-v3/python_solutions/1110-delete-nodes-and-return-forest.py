class Solution:
    def delNodes(self, root: TreeNode, to_delete: List[int]) -> List[TreeNode]:
        to_delete_set = set(to_delete)
        res = []

        def helper(node, is_root):
            if not node:
                return None
            node_deleted = node.val in to_delete_set
            if is_root and not node_deleted:
                res.append(node)
            node.left = helper(node.left, node_deleted)
            node.right = helper(node.right, node_deleted)
            return None if node_deleted else node

        helper(root, True)
        return res