import collections

class Solution:
    def reverseOddLevels(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root:
            return None

        q = collections.deque([(root, 0)])

        while q:
            level_size = len(q)
            current_level_nodes = []

            for _ in range(level_size):
                node, level = q.popleft()
                current_level_nodes.append(node)

                if node.left:
                    q.append((node.left, level + 1))
                if node.right:
                    q.append((node.right, level + 1))

            if level % 2 == 1:
                values_to_reverse = [n.val for n in current_level_nodes]
                values_to_reverse.reverse()

                for i in range(len(current_level_nodes)):
                    current_level_nodes[i].val = values_to_reverse[i]

        return root