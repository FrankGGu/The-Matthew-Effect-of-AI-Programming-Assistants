import collections

class Solution:
    def deepestLeavesSum(self, root: TreeNode) -> int:
        if not root:
            return 0

        queue = collections.deque([root])
        deepest_sum = 0

        while queue:
            current_level_sum = 0
            level_size = len(queue)

            for _ in range(level_size):
                node = queue.popleft()
                current_level_sum += node.val

                if node.left:
                    queue.append(node.left)
                if node.right:
                    queue.append(node.right)

            deepest_sum = current_level_sum

        return deepest_sum