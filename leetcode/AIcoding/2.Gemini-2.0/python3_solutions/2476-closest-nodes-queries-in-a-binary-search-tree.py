class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def closestNodes(self, root: TreeNode, queries: list[int]) -> list[list[int]]:
        arr = []
        def inorder(node):
            if not node:
                return
            inorder(node.left)
            arr.append(node.val)
            inorder(node.right)

        inorder(root)

        res = []
        for q in queries:
            smaller = -1
            larger = -1

            l, r = 0, len(arr) - 1
            while l <= r:
                mid = (l + r) // 2
                if arr[mid] <= q:
                    smaller = arr[mid]
                    l = mid + 1
                else:
                    r = mid - 1

            l, r = 0, len(arr) - 1
            while l <= r:
                mid = (l + r) // 2
                if arr[mid] >= q:
                    larger = arr[mid]
                    r = mid - 1
                else:
                    l = mid + 1

            res.append([smaller, larger])

        return res