class Solution:
    def recoverFromPreorder(self, traversal: str) -> TreeNode:
        stack = []
        i = 0
        n = len(traversal)

        while i < n:
            level = 0
            while i < n and traversal[i] == '-':
                level += 1
                i += 1

            val = 0
            while i < n and traversal[i].isdigit():
                val = val * 10 + int(traversal[i])
                i += 1

            node = TreeNode(val)

            if level == len(stack):
                if stack:
                    stack[-1].left = node
            else:
                while level < len(stack):
                    stack.pop()
                stack[-1].right = node

            stack.append(node)

        return stack[0] if stack else None