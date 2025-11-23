import collections

class Solution:
    def findBottomLeftValue(self, root: TreeNode) -> int:
        queue = collections.deque([root])
        bottom_left_value = root.val

        while queue:
            level_size = len(queue)
            bottom_left_value = queue[0].val 

            for _ in range(level_size):
                node = queue.popleft()

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

        return bottom_left_value