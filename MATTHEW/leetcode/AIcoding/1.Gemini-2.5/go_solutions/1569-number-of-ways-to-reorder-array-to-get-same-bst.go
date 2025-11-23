package main

const MOD int = 1e9 + 7

var combinations [][]int

func init() {
	// Max N is 1000. We need combinations up to C(N-1, k).
	// So, the table size should accommodate indices up to N-1.
	// We'll use maxN = 1001 to allow combinations[1000][k] if needed,
	// but for N elements, the largest combination needed is C(N-1, k).
	maxN := 1001 
	combinations = make([][]int, maxN)
	for i := 0; i < maxN; i++ {
		combinations[i] = make([]int, i+1)
		combinations[i][0] = 1
		for j := 1; j < i; j++ {
			combinations[i][j] = (combinations[i-1][j-1] + combinations[i-1][j]) % MOD
		}
		if i > 0 {
			combinations[i][i] = 1
		}
	}
}

func waysToReorder(nums []int) int {
	// The problem asks for (number of ways - 1) because the original order is one way.
	// So we call the recursive helper and subtract 1.
	// Add MOD before taking modulo to handle potential negative result from subtraction.
	return (dfs(nums) - 1 + MOD) % MOD
}

func dfs(nums []int) int {
	n := len(nums)
	if n <= 2 { // If 0, 1, or 2 elements, there's only 1 way to form the BST.
		return 1
	}

	root := nums[0]
	leftSubtree := []int{}
	rightSubtree := []int{}

	for i := 1; i < n; i++ {
		if nums[i] < root {
			leftSubtree = append(leftSubtree, nums[i])
		} else { // nums[i] > root (problem constraints guarantee distinct elements)
			rightSubtree = append(rightSubtree, nums[i])
		}
	}

	lenLeft := len(leftSubtree)
	lenRight := len(rightSubtree)

	// Number of ways to choose positions for left subtree elements from the remaining n-1 slots.
	// This is C(lenLeft + lenRight, lenLeft).
	comb := combinations[lenLeft+lenRight][lenLeft]

	// Total ways = C(lenLeft + lenRight, lenLeft) * ways(left_subtree) * ways(right_subtree)
	waysLeft := dfs(leftSubtree)
	waysRight := dfs(rightSubtree)

	res := (comb * waysLeft) % MOD
	res = (res * waysRight) % MOD

	return res
}