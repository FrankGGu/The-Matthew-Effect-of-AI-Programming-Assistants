import "math"

func minDiffInBST(root *TreeNode) int {
    minDiff := math.MaxInt32
    var prevVal int