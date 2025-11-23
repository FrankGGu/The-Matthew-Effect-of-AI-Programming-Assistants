class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

def mergeTrees(root1: TreeNode, root2: TreeNode) -> TreeNode:
    def inorder(node, lst):
        if node:
            inorder(node.left, lst)
            lst.append(node.val)
            inorder(node.right, lst)

    list1, list2 = [], []
    inorder(root1, list1)
    inorder(root2, list2)

    merged_list = sorted(list1 + list2)

    def sortedListToBST(start, end):
        if start > end:
            return None
        mid = (start + end) // 2
        node = TreeNode(merged_list[mid])
        node.left = sortedListToBST(start, mid - 1)
        node.right = sortedListToBST(mid + 1, end)
        return node

    return sortedListToBST(0, len(merged_list) - 1)