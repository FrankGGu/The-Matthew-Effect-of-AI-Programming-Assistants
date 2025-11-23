import (
	"sort"
)

func maxStrength(nums []int) int64 {
	sort.Ints(nums)
	n := len(nums)
	pos := []int{}
	neg := []int{}
	zeros := 0
	for _, num := range nums {
		if num > 0 {
			pos = append(pos, num)
		} else if num < 0 {
			neg = append(neg, num)
		} else {
			zeros++
		}
	}

	if len(pos) == 0 && len(neg) == 0 {
		return 0
	}

	if len(pos) == 0 && len(neg) == 1 && zeros > 0 {
		return 0
	}

	if len(pos) == 0 && len(neg)%2 != 0 {
		if zeros > 0 {
			return 0
		} else {
			res := int64(1)
			for i := 0; i < len(neg)-1; i++ {
				res *= int64(neg[i])
			}
			return res
		}
	}

	res := int64(1)
	for _, num := range pos {
		res *= int64(num)
	}

	if len(neg)%2 == 0 {
		for _, num := range neg {
			res *= int64(num)
		}
	} else {
		for i := 0; i < len(neg)-1; i++ {
			res *= int64(neg[i])
		}
	}

	return res
}