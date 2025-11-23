class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def recoverFromPreorder(traversal: str) -> TreeNode:
    def dfs(level):
        nonlocal index
        if index >= len(traversal) or dashes[index] != level:
            return None

        val = values[index]
        index += 1

        node = TreeNode(val)
        node.left = dfs(level + 1)
        node.right = dfs(level + 1)
        return node

    values = []
    dashes = []
    index = 0
    i = 0
    while i < len(traversal):
        level = 0
        while i < len(traversal) and traversal[i] == '-':
            level += 1
            i += 1
        dashes.append(level)

        val = 0
        while i < len(traversal) and traversal[i].isdigit():
            val = val * 10 + int(traversal[i])
            i += 1
        values.append(val)

    index = 0
    return dfs(0)