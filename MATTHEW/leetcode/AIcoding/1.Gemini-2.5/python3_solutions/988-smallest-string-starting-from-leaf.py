class Solution:
    def smallestFromLeaf(self, root: Optional[TreeNode]) -> str:
        self.smallest_string = None

        def dfs(node, current_chars_list):
            if not node:
                return

            current_chars_list.append(chr(node.val + ord('a')))

            if not node.left and not node.right:
                path_string = "".join(reversed(current_chars_list))
                if self.smallest_string is None or path_string < self.smallest_string:
                    self.smallest_string = path_string
            else:
                dfs(node.left, current_chars_list)
                dfs(node.right, current_chars_list)

            current_chars_list.pop()

        dfs(root, [])
        return self.smallest_string