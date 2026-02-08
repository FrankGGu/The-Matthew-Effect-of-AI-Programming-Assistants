class Solution:
    def getAllElements(self, root1: TreeNode, root2: TreeNode) -> List[int]:

        list1 = []
        list2 = []

        def inorder_traversal(node, arr):
            if not node:
                return
            inorder_traversal(node.left, arr)
            arr.append(node.val)
            inorder_traversal(node.right, arr)

        inorder_traversal(root1, list1)
        inorder_traversal(root2, list2)

        merged_list = []
        p1, p2 = 0, 0
        n1, n2 = len(list1), len(list2)

        while p1 < n1 and p2 < n2:
            if list1[p1] <= list2[p2]:
                merged_list.append(list1[p1])
                p1 += 1
            else:
                merged_list.append(list2[p2])
                p2 += 1

        while p1 < n1:
            merged_list.append(list1[p1])
            p1 += 1

        while p2 < n2:
            merged_list.append(list2[p2])
            p2 += 1

        return merged_list