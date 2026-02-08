from collections import deque

class Solution:
    def replaceValueInTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root:
            return None

        root.val = 0
        queue = deque([root])

        while queue:
            level_sum = 0
            level_nodes = []
            level_size = len(queue)

            for _ in range(level_size):
                node = queue.popleft()
                level_nodes.append(node)
                if node.left:
                    queue.append(node.left)
                    level_sum += node.left.val
                if node.right:
                    queue.append(node.right)
                    level_sum += node.right.val

            for node in level_nodes:
                children_sum = 0
                if node.left:
                    children_sum += node.left.val
                if node.right:
                    children_sum += node.right.val

                if node.left:
                    node.left.val = level_sum - children_sum
                if node.right:
                    node.right.val = level_sum - children_sum

        return root