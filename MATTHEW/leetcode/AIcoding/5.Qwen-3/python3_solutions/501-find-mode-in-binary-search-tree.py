class Solution:
    def findMode(self, root: TreeNode) -> List[int]:
        from collections import defaultdict

        def inorder(node):
            if not node:
                return
            inorder(node.left)
            count[node.val] += 1
            inorder(node.right)

        count = defaultdict(int)
        inorder(root)
        max_freq = max(count.values()) if count else 0
        return [k for k, v in count.items() if v == max_freq]