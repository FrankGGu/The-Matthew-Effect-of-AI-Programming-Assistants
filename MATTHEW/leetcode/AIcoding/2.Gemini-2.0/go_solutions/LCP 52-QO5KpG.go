type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func getNumber(root *TreeNode, l int, r int) int {
	if root == nil {
		return 0
	}
	if root.Val < l {
		return getNumber(root.Right, l, r)
	} else if root.Val > r {
		return getNumber(root.Left, l, r)
	} else {
		return 1 + getNumber(root.Left, l, r) + getNumber(root.Right, l, r)
	}
}

func getSum(root *TreeNode, l int, r int) int {
	if root == nil {
		return 0
	}
	if root.Val < l {
		return getSum(root.Right, l, r)
	} else if root.Val > r {
		return getSum(root.Left, l, r)
	} else {
		return root.Val + getSum(root.Left, l, r) + getSum(root.Right, l, r)
	}
}

func replaceValue(root *TreeNode, l int, r int, add int) {
	if root == nil {
		return
	}
	if root.Val < l {
		replaceValue(root.Right, l, r, add)
	} else if root.Val > r {
		replaceValue(root.Left, l, r, add)
	} else {
		root.Val += add
		replaceValue(root.Left, l, r, add)
		replaceValue(root.Right, l, r, add)
	}
}