class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def smallestMissingValue(self, root: TreeNode) -> List[int]:
        def dfs(node, present):
            if not node:
                return
            present.add(node.val)
            dfs(node.left, present)
            dfs(node.right, present)

        def find_missing(present):
            missing = 1
            while missing in present:
                missing += 1
            return missing

        result = []
        def traverse(node):
            if not node:
                return
            present = set()
            dfs(node, present)
            result.append(find_missing(present))
            traverse(node.left)
            traverse(node.right)

        traverse(root)
        return result