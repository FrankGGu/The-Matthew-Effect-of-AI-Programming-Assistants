class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def longestZigZag(self, root: TreeNode) -> int:
        self.max_len = 0

        # dfs returns (longest_path_ending_left, longest_path_ending_right)
        # longest_path_ending_left: longest zigzag path starting from current node by first going left.
        #                           This path continues by alternating directions from the left child.
        # longest_path_ending_right: longest zigzag path starting from current node by first going right.
        #                            This path continues by alternating directions from the right child.
        def dfs(node):
            if not node:
                return (0, 0) # A null node cannot start a path, so path length is 0.

            # Recursively get zigzag path lengths for children
            # left_res_left: longest zigzag path starting from node.left by going left first.
            # left_res_right: longest zigzag path starting from node.left by going right first.
            left_res_left, left_res_right = dfs(node.left)

            # right_res_left: longest zigzag path starting from node.right by going left first.
            # right_res_right: longest zigzag path starting from node.right by going right first.
            right_res_left, right_res_right = dfs(node.right)

            # Calculate current node's longest zigzag path by going left first.
            # If we go left from current node, the next step from node.left must be right.
            current_go_left_len = 0
            if node.left:
                current_go_left_len = 1 + left_res_right

            # Calculate current node's longest zigzag path by going right first.
            # If we go right from current node, the next step from node.right must be left.
            current_go_right_len = 0
            if node.right:
                current_go_right_len = 1 + right_res_left

            # Update the global maximum length found so far
            self.max_len = max(self.max_len, current_go_left_len, current_go_right_len)

            # Return the calculated lengths for the current node
            return (current_go_left_len, current_go_right_len)

        dfs(root)
        return self.max_len