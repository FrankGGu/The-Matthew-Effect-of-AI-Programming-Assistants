class Solution:
    def minCameraCover(self, root: Optional[TreeNode]) -> int:
        self.cameras = 0

        # States for a node after processing its children:
        # 0: The node needs to be covered by its parent.
        # 1: The node is covered, but does not have a camera.
        # 2: The node has a camera.

        def dfs(node):
            if not node:
                # A null node is considered covered and doesn't need a camera.
                # This allows a leaf node to correctly determine its state based on its null children.
                return 1

            left_state = dfs(node.left)
            right_state = dfs(node.right)

            # Case 1: If any child needs to be covered (state 0),
            # the current node MUST have a camera to cover that child.
            if left_state == 0 or right_state == 0:
                self.cameras += 1
                return 2  # Current node has a camera

            # Case 2: If any child has a camera (state 2),
            # the current node is covered by that child's camera.
            # It doesn't need a camera itself and doesn't need its parent to cover it.
            if left_state == 2 or right_state == 2:
                return 1  # Current node is covered, no camera

            # Case 3: If both children are covered but neither has a camera (state 1),
            # the current node is not covered by its children.
            # It also doesn't have a camera itself.
            # So, the current node needs to be covered by its parent.
            return 0  # Current node needs parent to cover it

        # After the DFS traversal, if the root itself needs to be covered (state 0),
        # we must place a camera on the root.
        if dfs(root) == 0:
            self.cameras += 1

        return self.cameras