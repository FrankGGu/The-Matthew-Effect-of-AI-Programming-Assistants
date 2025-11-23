class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def minCameraCover(self, root: TreeNode) -> int:
        self.cameras = 0

        # States for a node after processing its children:
        # 0: Node needs a camera (must be covered by its parent or itself)
        # 1: Node has a camera
        # 2: Node is covered by one of its children's cameras

        def dfs(node):
            if not node:
                return 2  # Null nodes are considered covered and don't need cameras

            left_state = dfs(node.left)
            right_state = dfs(node.right)

            # Case 1: If any child needs a camera, the current node must have a camera.
            if left_state == 0 or right_state == 0:
                self.cameras += 1
                return 1  # Current node has a camera

            # Case 2: If any child has a camera, the current node is covered by it.
            if left_state == 1 or right_state == 1:
                return 2  # Current node is covered by a child's camera

            # Case 3: Both children are covered (state 2) but don't have cameras.
            # The current node is not covered by its children and doesn't have a camera.
            # Therefore, it needs its parent to cover it.
            return 0  # Current node needs a camera (from its parent)

        # After the DFS traversal, if the root itself needs a camera (state 0),
        # it means there's no parent to cover it, so we must place a camera on the root.
        if dfs(root) == 0:
            self.cameras += 1

        return self.cameras