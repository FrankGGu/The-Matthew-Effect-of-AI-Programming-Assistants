class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def recoverFromPreorder(S: str) -> TreeNode:
    stack = []
    i = 0
    while i < len(S):
        level = 0
        while i < len(S) and S[i] == '-':
            level += 1
            i += 1
        val = 0
        while i < len(S) and S[i].isdigit():
            val = val * 10 + int(S[i])
            i += 1
        node = TreeNode(val)
        if level == len(stack):
            if stack:
                stack[-1].left = node
            stack.append(node)
        else:
            while level < len(stack):
                stack.pop()
            stack[-1].right = node
            stack.append(node)
    return stack[0]