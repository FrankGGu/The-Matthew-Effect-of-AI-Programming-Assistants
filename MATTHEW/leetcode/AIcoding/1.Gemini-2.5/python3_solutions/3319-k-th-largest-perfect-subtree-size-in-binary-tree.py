class Solution:
    def kthLargestPerfectSubtreeSize(self, root: Optional[TreeNode], k: int) -> int:
        perfect_subtree_sizes = []

        def dfs(node):
            if not node:
                return -1, True

            left_height, left_is_perfect = dfs(node.left)
            right_height, right_is_perfect = dfs(node.right)

            if left_is_perfect and right_is_perfect and left_height == right_height:
                current_height = left_height + 1
                current_size = (1 << (current_height + 1)) - 1
                perfect_subtree_sizes.append(current_size)
                return current_height, True
            else:
                return -1, False

        dfs(root)

        perfect_subtree_sizes.sort(reverse=True)

        return perfect_subtree_sizes[k - 1]