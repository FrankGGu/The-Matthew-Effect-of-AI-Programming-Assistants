/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func getAllElements(root1 *TreeNode, root2 *TreeNode) []int {
    var list1, list2 []int
    inOrder(root1, &list1)
    inOrder(root2, &list2)
    return merge(list1, list2)
}

func inOrder(node *TreeNode, list *[]int) {
    if node == nil {
        return
    }
    inOrder(node.Left, list)
    *list = append(*list, node.Val)
    inOrder(node.Right, list)
}

func merge(list1, list2 []int) []int {
    res := make([]int, 0, len(list1)+len(list2))
    i, j := 0, 0
    for i < len(list1) && j < len(list2) {
        if list1[i] < list2[j] {
            res = append(res, list1[i])
            i++
        } else {
            res = append(res, list2[j])
            j++
        }
    }
    res = append(res, list1[i:]...)
    res = append(res, list2[j:]...)
    return res
}