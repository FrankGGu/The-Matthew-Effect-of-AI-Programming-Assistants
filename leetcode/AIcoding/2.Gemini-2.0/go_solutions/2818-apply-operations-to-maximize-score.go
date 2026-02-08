import (
	"sort"
)

func maxScore(nums []int, k int) int {
	const mod int = 1e9 + 7
	n := len(nums)
	l := make([]int, n)
	r := make([]int, n)
	stack := []int{}

	for i := 0; i < n; i++ {
		for len(stack) > 0 && nums[stack[len(stack)-1]] < nums[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			l[i] = 0
		} else {
			l[i] = stack[len(stack)-1] + 1
		}
		stack = append(stack, i)
	}

	stack = []int{}
	for i := n - 1; i >= 0; i-- {
		for len(stack) > 0 && nums[stack[len(stack)-1]] <= nums[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			r[i] = n - 1
		} else {
			r[i] = stack[len(stack)-1] - 1
		}
		stack = append(stack, i)
	}

	type Pair struct {
		Val int
		Idx int
	}
	pairs := make([]Pair, n)
	for i := 0; i < n; i++ {
		pairs[i] = Pair{nums[i], i}
	}
	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].Val > pairs[j].Val
	})

	ans := 1
	for i := 0; i < n && k > 0; i++ {
		val := pairs[i].Val
		idx := pairs[i].Idx
		count := r[idx] - l[idx] + 1
		take := min(k, count)
		ans = (ans * pow(val, take, mod)) % mod
		k -= take
	}

	return ans
}

func pow(base, exp, mod int) int {
	res := 1
	base %= mod
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % mod
		}
		base = (base * base) % mod
		exp /= 2
	}
	return res
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}