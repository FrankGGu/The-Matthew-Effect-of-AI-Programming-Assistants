class Solution:
    def treeQueries(self, root: Optional[TreeNode], queries: List[int]) -> List[int]:
        heights = {}
        depths = {}
        ans = {}

        def calculate_height_depth(node, d):
            if not node:
                return -1

            depths[node.val] = d
            left_h = calculate_height_depth(node.left, d + 1)
            right_h = calculate_height_depth(node.right, d + 1)
            heights[node.val] = 1 + max(left_h, right_h)
            return heights[node.val]

        calculate_height_depth(root, 0)

        def dfs_ans(node, max_depth_from_other_branches_above):
            if not node:
                return

            ans[node.val] = max_depth_from_other_branches_above

            max_depth_for_left_child = max_depth_from_other_branches_above
            if node.right:
                max_depth_for_left_child = max(max_depth_for_left_child, depths[node.right] + heights[node.right])

            max_depth_for_right_child = max_depth_from_other_branches_above
            if node.left:
                max_depth_for_right_child = max(max_depth_for_right_child, depths[node.left] + heights[node.left])

            dfs_ans(node.left, max_depth_for_left_child)
            dfs_ans(node.right, max_depth_for_right_child)

        dfs_ans(root, -1)

        result = [ans[q] for q in queries]
        return result