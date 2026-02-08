import (
	"math"
)

type Node struct {
	val    int
	height int
	left   *Node
	right  *Node
}

func height(node *Node) int {
	if node == nil {
		return 0
	}
	return node.height
}

func updateHeight(node *Node) {
	if node != nil {
		node.height = 1 + max(height(node.left), height(node.right))
	}
}

func balanceFactor(node *Node) int {
	if node == nil {
		return 0
	}
	return height(node.left) - height(node.right)
}

func rotateRight(y *Node) *Node {
	x := y.left
	T2 := x.right

	x.right = y
	y.left = T2

	updateHeight(y)
	updateHeight(x)

	return x
}

func rotateLeft(x *Node) *Node {
	y := x.right
	T2 := y.left

	y.left = x
	x.right = T2

	updateHeight(x)
	updateHeight(y)

	return y
}

func insert(node *Node, val int) *Node {
	if node == nil {
		return &Node{val: val, height: 1}
	}

	if val < node.val {
		node.left = insert(node.left, val)
	} else { // Allow duplicates, insert to right
		node.right = insert(node.right, val)
	}

	updateHeight(node)

	balance := balanceFactor(node)

	// Left Left Case
	if balance > 1 && val < node.left.val {
		return rotateRight(node)
	}

	// Right Right Case
	if balance < -1 && val > node.right.val {
		return rotateLeft(node)
	}

	// Left Right Case
	if balance > 1 && val > node.left.val {
		node.left = rotateLeft(node.left)
		return rotateRight(node)
	}

	// Right Left Case
	if balance < -1 && val < node.right.val {
		node.right = rotateRight(node.right)
		return rotateLeft(node)
	}

	return node
}

func findClosest(node *Node, target int) int {
	minDiff := math.MaxInt33 // A value larger than any possible difference (2 * 10^9)

	curr := node
	for curr != nil {
		diff := abs(curr.val - target)
		if diff < minDiff {
			minDiff = diff
		}

		if target == curr.val {
			return 0 // Found exact match, difference is 0
		} else if target < curr.val {
			curr = curr.left
		} else {
			curr = curr.right
		}
	}
	return minDiff
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func minAbsoluteDifference(nums []int, x int) int {
	n := len(nums)
	minDiff := math.MaxInt33 // Initialize with a very large value

	// Pass 1: Consider j <= i - x
	// Build an AVL tree of elements nums[k] where k <= i - x
	var leftTreeRoot *Node
	for i := 0; i < n; i++ {
		if i >= x {
			// Add nums[i-x] to the leftTree
			leftTreeRoot = insert(leftTreeRoot, nums[i-x])
		}

		// Query the leftTree for nums[i]
		if leftTreeRoot != nil { // Only query if tree is not empty
			currentMinDiff := findClosest(leftTreeRoot, nums[i])
			if currentMinDiff < minDiff {
				minDiff = currentMinDiff
			}
		}
	}

	// Pass 2: Consider j >= i + x
	// Build an AVL tree of elements nums[k] where k >= i + x
	var rightTreeRoot *Node
	for i := n - 1; i >= 0; i-- {
		if i+x < n {
			// Add nums[i+x] to the rightTree
			rightTreeRoot = insert(rightTreeRoot, nums[i+x])
		}

		// Query the rightTree for nums[i]
		if rightTreeRoot != nil { // Only query if tree is not empty
			currentMinDiff := findClosest(rightTreeRoot, nums[i])
			if currentMinDiff < minDiff {
				minDiff = currentMinDiff
			}
		}
	}

	return minDiff
}