func maxRotateFunction(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    sum := 0
    currentF := 0

    // Calculate initial sum of all elements and F(0)
    for i := 0; i < n