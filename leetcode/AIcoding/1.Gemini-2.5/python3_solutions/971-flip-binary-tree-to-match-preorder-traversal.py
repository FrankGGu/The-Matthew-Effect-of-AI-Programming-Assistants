class Solution:
    def flipMatchVoyage(self, root: Optional[TreeNode], voyage: List[int]) -> List[int]:
        self.idx = 0
        self.ans = []
        self.possible = True

        def dfs(node):
            if not self.possible:
                return

            if not node:
                return

            if self.idx >= len(voyage) or node.val != voyage[self.idx]:
                self.possible = False
                return

            self.idx += 1

            if node.left:
                # If left child matches the next expected value in voyage
                if self.idx < len(voyage) and node.left.val == voyage[self.idx]:
                    dfs(node.left)
                    if self.possible: # Only proceed to right if still possible
                        dfs(node.right)
                else: # Left child does not match, check if flipping helps
                    if node.right and self.idx < len(voyage) and node.right.val == voyage[self.idx]:
                        self.ans.append(node.val) # Record flip
                        dfs(node.right) # Process right child (now effectively left)
                        if self.possible: # Only proceed to left if still possible
                            dfs(node.left)  # Process left child (now effectively right)
                    else: # Neither standard left nor flipped right matches
                        self.possible = False
            else: # No left child, just process right
                dfs(node.right)

        dfs(root)

        if not self.possible or self.idx != len(voyage):
            return [-1]
        return self.ans