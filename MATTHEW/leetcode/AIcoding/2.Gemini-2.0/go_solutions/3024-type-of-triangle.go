import (
	"sort"
)

func triangleType(nums []int) string {
	sort.Ints(nums)
	a, b, c := nums[0], nums[1], nums[2]

	if a+b <= c {
		return "Not A Triangle"
	} else if a == b && b == c {
		return "Equilateral"
	} else if a == b || b == c || a == c {
		return "Isosceles"
	} else {
		return "Scalene"
	}
}