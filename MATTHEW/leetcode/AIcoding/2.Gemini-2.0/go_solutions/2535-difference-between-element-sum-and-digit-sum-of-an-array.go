import "fmt"

func differenceOfSum(nums []int) int {
	elementSum := 0
	digitSum := 0
	for _, num := range nums {
		elementSum += num
		for num > 0 {
			digitSum += num % 10
			num /= 10
		}
	}
	diff := elementSum - digitSum
	if diff < 0 {
		return -diff
	}
	return diff
}