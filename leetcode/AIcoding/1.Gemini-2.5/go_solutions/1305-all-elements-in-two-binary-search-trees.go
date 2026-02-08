func getAllElements(root1 *TreeNode, root2 *TreeNode) []int {
    list1 := []int{}
    list2 := []int{}

    inorder(root1, &list1)
    inorder(root2, &list2)

    result := []int{}
    i, j := 0, 0

    for i < len(list1) && j < len(list2) {
        if list1[i] <= list2[j] {
            result = append(result, list1[i])
            i++
        } else {
            result = append(result, list2[j])
            j++
        }
    }

    for i < len(list1) {
        result = append(result, list1[i])
        i++
    }

    for j < len(list2) {
        result = append(result, list2[j])
        j++
    }

    return result
}

func inorder(node *TreeNode, list *[]int) {
    if node == nil {
        return
    }
    inorder(node.Left, list)
    *list = append(*list, node.Val)
    inorder(node.Right, list)
}