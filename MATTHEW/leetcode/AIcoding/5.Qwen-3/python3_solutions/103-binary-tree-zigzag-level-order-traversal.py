from collections import deque, defaultdict

class Solution:
    def zigzagLevelOrder(self, root: TreeNode) -> List[List[int]]:
        if not root:
            return []

        result = []
        queue = deque([(root, 0)])
        level_dict = defaultdict(list)

        while queue:
            node, level = queue.popleft()
            level_dict[level].append(node.val)
            if node.left:
                queue.append((node.left, level + 1))
            if node.right:
                queue.append((node.right, level + 1))

        for level in sorted(level_dict.keys()):
            if level % 2 == 1:
                result.append(level_dict[level][::-1])
            else:
                result.append(level_dict[level])

        return result