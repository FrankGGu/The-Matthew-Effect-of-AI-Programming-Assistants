package main

type ListNode struct {
	Val  int
	Next *ListNode
}

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func twoSum(nums []int, target int) []int {
	numMap := make(map[int]int)
	for i, num := range nums {
		complement := target - num
		if j, ok := numMap[complement]; ok {
			return []int{j, i}
		}
		numMap[num] = i
	}
	return nil
}

func reverse(x int) int {
	var reversed int
	for x != 0 {
		pop := x % 10
		x /= 10
		if reversed > math.MaxInt32/10 || (reversed == math.MaxInt32/10 && pop > 7) {
			return 0
		}
		if reversed < math.MinInt32/10 || (reversed == math.MinInt32/10 && pop < -8) {
			return 0
		}
		reversed = reversed*10 + pop
	}
	return reversed
}

func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
	dummy := &ListNode{}
	current := dummy
	carry := 0
	for l1 != nil || l2 != nil {
		val1 := 0
		if l1 != nil {
			val1 = l1.Val
		}
		val2 := 0
		if l2 != nil {
			val2 = l2.Val
		}
		sum := val1 + val2 + carry
		carry = sum / 10
		current.Next = &ListNode{Val: sum % 10}
		current = current.Next
		if l1 != nil {
			l1 = l1.Next
		}
		if l2 != nil {
			l2 = l2.Next
		}
	}
	if carry > 0 {
		current.Next = &ListNode{Val: carry}
	}
	return dummy.Next
}

func lengthOfLongestSubstring(s string) int {
	charIndex := make(map[byte]int)
	left := 0
	maxLength := 0
	for right, char := range s {
		if index, ok := charIndex[char]; ok && index >= left {
			left = index + 1
		}
		charIndex[char] = right
		if right-left+1 > maxLength {
			maxLength = right - left + 1
		}
	}
	return maxLength
}

func medianSlidingWindow(nums []int, k int) []float64 {
	result := make([]float64, 0)
	for i := 0; i <= len(nums)-k; i++ {
		window := make([]int, k)
		copy(window, nums[i:i+k])
		sort.Ints(window)
		if k%2 == 1 {
			result = append(result, float64(window[k/2]))
		} else {
			result = append(result, float64(window[k/2-1]+window[k/2])/2)
		}
	}
	return result
}

func maxSubArray(nums []int) int {
	maxCurrent := nums[0]
	maxGlobal := nums[0]
	for i := 1; i < len(nums); i++ {
		maxCurrent = max(maxCurrent+nums[i], nums[i])
		if maxCurrent > maxGlobal {
			maxGlobal = maxCurrent
		}
	}
	return maxGlobal
}

func generate(numRows int) [][]int {
	result := make([][]int, numRows)
	for i := 0; i < numRows; i++ {
		row := make([]int, i+1)
		row[0] = 1
		row[i] = 1
		for j := 1; j < i; j++ {
			row[j] = result[i-1][j-1] + result[i-1][j]
		}
		result[i] = row
	}
	return result
}

func climbStairs(n int) int {
	if n == 1 {
		return 1
	}
	if n == 2 {
		return 2
	}
	a, b := 1, 2
	for i := 3; i <= n; i++ {
		a, b = b, a+b
	}
	return b
}

func mergeTwoLists(l1 *ListNode, l2 *ListNode) *ListNode {
	dummy := &ListNode{}
	current := dummy
	for l1 != nil && l2 != nil {
		if l1.Val < l2.Val {
			current.Next = l1
			l1 = l1.Next
		} else {
			current.Next = l2
			l2 = l2.Next
		}
		current = current.Next
	}
	if l1 != nil {
		current.Next = l1
	} else {
		current.Next = l2
	}
	return dummy.Next
}

func hasCycle(head *ListNode) bool {
	slow, fast := head, head
	for fast != nil && fast.Next != nil {
		slow = slow.Next
		fast = fast.Next.Next
		if slow == fast {
			return true
		}
	}
	return false
}

func isPalindrome(head *ListNode) bool {
	slow, fast := head, head
	for fast != nil && fast.Next != nil {
		slow = slow.Next
		fast = fast.Next.Next
	}
	prev := (*ListNode)(nil)
	for slow != nil {
		next := slow.Next
		slow.Next = prev
		prev = slow
		slow = next
	}
	for head != nil && prev != nil {
		if head.Val != prev.Val {
			return false
		}
		head = head.Next
		prev = prev.Next
	}
	return true
}

func findKthLargest(nums []int, k int) int {
	sort.Ints(nums)
	return nums[len(nums)-k]
}

func maxDepth(root *TreeNode) int {
	if root == nil {
		return 0
	}
	left := maxDepth(root.Left)
	right := maxDepth(root.Right)
	if left > right {
		return left + 1
	}
	return right + 1
}

func isSameTree(p *TreeNode, q *TreeNode) bool {
	if p == nil && q == nil {
		return true
	}
	if p == nil || q == nil {
		return false
	}
	return p.Val == q.Val && isSameTree(p.Left, q.Left) && isSameTree(p.Right, q.Right)
}

func isBalanced(root *TreeNode) bool {
	if root == nil {
		return true
	}
	leftHeight := maxDepth(root.Left)
	rightHeight := maxDepth(root.Right)
	if abs(leftHeight-rightHeight) > 1 {
		return false
	}
	return isBalanced(root.Left) && isBalanced(root.Right)
}

func levelOrder(root *TreeNode) [][]int {
	result := [][]int{}
	if root == nil {
		return result
	}
	queue := []*TreeNode{root}
	for len(queue) > 0 {
		levelSize := len(queue)
		level := make([]int, levelSize)
		for i := 0; i < levelSize; i++ {
			node := queue[0]
			queue = queue[1:]
			level[i] = node.Val
			if node.Left != nil {
				queue = append(queue, node.Left)
			}
			if node.Right != nil {
				queue = append(queue, node.Right)
			}
		}
		result = append(result, level)
	}
	return result
}

func minDepth(root *TreeNode) int {
	if root == nil {
		return 0
	}
	if root.Left == nil && root.Right == nil {
		return 1
	}
	minLeft := minDepth(root.Left)
	minRight := minDepth(root.Right)
	if minLeft == 0 {
		return minRight + 1
	}
	if minRight == 0 {
		return minLeft + 1
	}
	return min(minLeft, minRight) + 1
}

func maxPathSum(root *TreeNode) int {
	type Result struct {
		Sum int
	}
	var maxSum int = math.MinInt32
	var dfs func(node *TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		left := max(0, dfs(node.Left))
		right := max(0, dfs(node.Right))
		currentSum := node.Val + left + right
		if currentSum > maxSum {
			maxSum = currentSum
		}
		return node.Val + max(left, right)
	}
	dfs(root)
	return maxSum
}

func findMode(root *TreeNode) []int {
	var result []int
	var prev *TreeNode
	var count int
	var maxCount int
	var traverse func(node *TreeNode)
	traverse = func(node *TreeNode) {
		if node == nil {
			return
		}
		traverse(node.Left)
		if prev != nil && prev.Val == node.Val {
			count++
		} else {
			count = 1
		}
		if count > maxCount {
			maxCount = count
			result = []int{node.Val}
		} else if count == maxCount {
			result = append(result, node.Val)
		}
		prev = node