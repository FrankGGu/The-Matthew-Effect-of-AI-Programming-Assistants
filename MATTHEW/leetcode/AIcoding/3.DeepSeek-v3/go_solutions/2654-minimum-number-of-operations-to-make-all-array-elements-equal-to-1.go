func minOperations(nums []int) int {
    n := len(nums)
    ones := 0
    for _, num := range nums {
        if num == 1 {
            ones++
        }
    }
    if ones > 0 {
        return n - ones
    }

    minOps := -1
    for i := 0; i < n; i++ {
        currentGcd := nums[i]
        for j := i + 1; j < n; j++ {
            currentGcd = gcd(currentGcd, nums[j])
            if currentGcd == 1 {
                ops := j - i + (n - 1)
                if minOps == -1 || ops < minOps {
                    minOps = ops
                }
                break
            }
        }
    }
    return minOps
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}