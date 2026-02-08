type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func findFrequentTreeSum(root *TreeNode) []int {
    sumCount := make(map[int]int)
    var maxCount int

    var postOrder func(node *TreeNode) int
    postOrder = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        sum := node.Val + postOrder(node.Left) + postOrder(node.Right)
        sumCount[sum]++
        if sumCount[sum] > maxCount {
            maxCount = sumCount[sum]
        }
        return sum
    }

    postOrder(root)

    result := []int{}
    for sum, count := range sumCount {
        if count == maxCount {
            result = append(result, sum)
        }
    }
    return result
}