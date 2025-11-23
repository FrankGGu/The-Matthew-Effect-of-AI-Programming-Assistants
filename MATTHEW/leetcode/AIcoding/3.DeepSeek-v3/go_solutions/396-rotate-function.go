func maxRotateFunction(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    sum := 0
    f := 0
    for i, num := range nums {
        sum += num
        f += i * num
    }

    maxF := f
    for i := n - 1; i > 0; i-- {
        f += sum - n * nums[i]
        if f > maxF {
            maxF = f
        }
    }

    return maxF
}