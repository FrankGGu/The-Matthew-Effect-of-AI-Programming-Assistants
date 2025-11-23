class Solution:
    def recoverFromPreorder(self, S: str) -> TreeNode:
        stack = []

        i = 0
        n = len(S)

        root = None

        while i < n:
            depth = 0
            while i < n and S[i] == '-':
                depth += 1
                i += 1

            val_start = i
            while i < n and S[i].isdigit():
                i += 1
            val = int(S[val_start:i])

            current_node = TreeNode(val)

            if not root:
                root = current_node

            while stack and stack[-1][1] >= depth:
                stack.pop()

            if stack:
                parent_node, parent_depth = stack[-1]
                if parent_node.left is None:
                    parent_node.left = current_node
                else:
                    parent_node.right = current_node

            stack.append((current_node, depth))

        return root