class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def isCompleteTree(root: TreeNode) -> bool:
    if not root:
        return True

    queue = [root]
    flag = False

    while queue:
        node = queue.pop(0)

        if not node:
            flag = True
        else:
            if flag:
                return False
            queue.append(node.left)
            queue.append(node.right)

    return True