import collections
from typing import Optional

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def widthOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        max_width = 0
        # Queue stores tuples of (node, index).
        # The index represents its position in a complete binary tree:
        # root is at 0, left child of node i is 2*i, right child is 2*i + 1.
        # We normalize indices for each level to keep them small and prevent potential overflow.
        queue = collections.deque([(root, 0)]) 

        while queue:
            level_length = len(queue)

            # Get the index of the first node in the current level.
            # This index will be used to normalize indices for children in the next level.
            level_start_index = queue[0][1]

            # Get the index of the last node in the current level.
            # This is used to calculate the width of the current level.
            level_end_index = queue[-1][1]

            # Calculate the width of the current level and update max_width.
            max_width = max(max_width, level_end_index - level_start_index + 1)

            # Process all nodes in the current level.
            for _ in range(level_length):
                node, index = queue.popleft()

                # Add children to the queue.
                # Normalize their indices relative to the 'level_start_index'
                # to keep the numbers small. The relative difference (width) remains correct.
                if node.left:
                    queue.append((node.left, 2 * (index - level_start_index)))
                if node.right:
                    queue.append((node.right, 2 * (index - level_start_index) + 1))

        return max_width