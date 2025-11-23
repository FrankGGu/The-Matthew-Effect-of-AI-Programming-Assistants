import "sort"

func maximumProduct(nums []int) int {
	sort.Ints(nums)
	n := len(nums)

	// The maximum product can be either:
	// 1. The product of the three largest numbers. (e.g., [1,2,3,4] -> 4*3*2 = 24)
	// 2. The product of the two smallest (most negative) numbers and the largest number.
	//    (e.g., [-100, -2, -3, 1, 2, 3, 4] -> (-100)*(-3)*4 = 1200)

	product1 := nums[n-1] * nums[n-2] * nums[n-3]
	product2 := nums[0] * nums[1] * nums[n-1]

	if product1 > product2 {
		return product1
	}
	return product2
}