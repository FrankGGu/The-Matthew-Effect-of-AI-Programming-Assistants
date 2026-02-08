class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def balanceBST(root: TreeNode) -> TreeNode:
    def inorder(node):
        if not node:
            return []
        return inorder(node.left) + [node.val] + inorder(node.right)

    def sorted_array_to_bst(arr):
        if not arr:
            return None
        mid = len(arr) // 2
        node = TreeNode(arr[mid])
        node.left = sorted_array_to_bst(arr[:mid])
        node.right = sorted_array_to_bst(arr[mid + 1:])
        return node

    sorted_vals = inorder(root)
    return sorted_array_to_bst(sorted_vals)