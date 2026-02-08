import "strconv"

func tree2str(root *TreeNode) string {
    if root == nil {
        return ""
    }

    result := strconv.Itoa(