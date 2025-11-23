import (
	"sort"
)

func numSquarefulPerms(nums []int) int {
	n := len(nums)
	sort.Ints(nums)
	count := 0
	var permute func(arr []int, used []bool, current []int)
	permute = func(arr []int, used []bool, current []int) {
		if len(current) == n {
			count++
			return
		}
		for i := 0; i < n; i++ {
			if used[i] {
				continue
			}
			if i > 0 && arr[i] == arr[i-1] && !used[i-1] {
				continue
			}
			if len(current) > 0 {
				sum := current[len(current)-1] + arr[i]
				root := int(sqrt(float64(sum)))
				if root*root != sum {
					continue
				}
			}
			usedCopy := make([]bool, n)
			copy(usedCopy, used)
			usedCopy[i] = true
			permute(arr, usedCopy, append(current, arr[i]))
		}
	}
	used := make([]bool, n)
	permute(nums, used, []int{})
	return count
}

func sqrt(x float64) float64 {
	if x < 0 {
		return 0
	}
	low := 0.0
	high := x
	if x > 1 {
		high = x
	} else {
		high = 1
	}
	for high-low > 1e-6 {
		mid := (low + high) / 2
		if mid*mid > x {
			high = mid
		} else {
			low = mid
		}
	}
	return low
}