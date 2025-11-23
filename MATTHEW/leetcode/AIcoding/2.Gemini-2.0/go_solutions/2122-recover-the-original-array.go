import (
	"sort"
)

func recoverArray(nums []int) []int {
	sort.Ints(nums)
	n := len(nums)
	for i := 1; i < n; i++ {
		if (nums[i]-nums[0])%2 == 0 {
			k := (nums[i] - nums[0]) / 2
			if k == 0 {
				continue
			}
			res := make([]int, 0)
			used := make([]bool, n)
			used[0] = true
			j := 1
			count := 0
			for l := 1; l < n; l++ {
				if used[l] {
					continue
				}
				for ; j < n; j++ {
					if !used[j] && nums[j] == nums[l]+2*k {
						res = append(res, nums[l]+k)
						used[l] = true
						used[j] = true
						count++
						j++
						break
					}
				}
				if j == n && !used[l] {
					res = []int{}
					break
				}

			}
			if len(res) == n/2 {
				return res
			}
		}
	}
	return []int{}
}