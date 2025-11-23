class Solution:
    def closestNodes(self, root: Optional[TreeNode], queries: List[int]) -> List[List[int]]:
        sorted_values = []
        def inorder(node):
            if not node:
                return
            inorder(node.left)
            sorted_values.append(node.val)
            inorder(node.right)
        inorder(root)

        res = []
        for q in queries:
            min_val = -1
            max_val = -1
            left, right = 0, len(sorted_values) - 1
            while left <= right:
                mid = (left + right) // 2
                if sorted_values[mid] <= q:
                    min_val = sorted_values[mid]
                    left = mid + 1
                else:
                    right = mid - 1
            left, right = 0, len(sorted_values) - 1
            while left <= right:
                mid = (left + right) // 2
                if sorted_values[mid] >= q:
                    max_val = sorted_values[mid]
                    right = mid - 1
                else:
                    left = mid + 1
            res.append([min_val, max_val])
        return res