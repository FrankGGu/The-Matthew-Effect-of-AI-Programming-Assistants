class Solution:
    def delNodes(self, root: Optional[TreeNode], to_delete: List[int]) -> List[TreeNode]:
        to_delete_set = set(to_delete)
        ans = []

        def dfs(node, is_root):
            if not node:
                return None

            deleted = node.val in to_delete_set

            node.left = dfs(node.left, deleted)
            node.right = dfs(node.right, deleted)

            if deleted:
                return None
            else:
                if is_root:
                    ans.append(node)
                return node

        dfs(root, True)
        return ans