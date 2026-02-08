class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def isEvenOddTree(root: TreeNode) -> bool:
    if not root:
        return True

    from collections import deque

    queue = deque([root])
    level = 0

    while queue:
        level_length = len(queue)
        prev_value = None

        for i in range(level_length):
            node = queue.popleft()

            if (level % 2 == 0 and (node.val % 2 == 0 or (prev_value is not None and node.val <= prev_value))) or \
               (level % 2 == 1 and (node.val % 2 == 1 or (prev_value is not None and node.val >= prev_value))):
                return False

            prev_value = node.val

            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

        level += 1

    return True