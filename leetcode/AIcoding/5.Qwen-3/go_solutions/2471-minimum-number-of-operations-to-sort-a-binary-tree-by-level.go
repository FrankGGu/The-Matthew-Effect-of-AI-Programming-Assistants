package main


func minimumOperationsBST(root *TreeNode) int {
    var levelOrder []int
    queue := []*TreeNode{root}
    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            node := queue[0]
            queue = queue[1:]
            levelOrder = append(levelOrder, node.Val)
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
    }

    sorted := make([]int, len(levelOrder))
    copy(sorted, levelOrder)
    sort.Ints(sorted)

    indexMap := make(map[int]int)
    for i, val := range sorted {
        indexMap[val] = i
    }

    visited := make([]bool, len(levelOrder))
    result := 0

    for i := 0; i < len(levelOrder); i++ {
        if visited[i] {
            continue
        }
        cycleLength := 0
        j := i
        for !visited[j] {
            visited[j] = true
            next := indexMap[levelOrder[j]]
            j = next
            cycleLength++
        }
        if cycleLength > 1 {
            result += cycleLength - 1
        }
    }

    return result
}