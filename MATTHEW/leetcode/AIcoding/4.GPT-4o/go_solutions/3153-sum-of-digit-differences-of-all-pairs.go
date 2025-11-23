func sumOfDigitDifference(nums []int) int {
    total := 0
    for i := 0; i < len(nums); i++ {
        for j := 0; j < len(nums); j++ {
            if i != j {
                total += digitDifference(nums[i], nums[j])
            }
        }
    }
    return total
}

func digitDifference(a, b int) int {
    diff := 0
    for a > 0 || b > 0 {
        digitA := a % 10
        digitB := b % 10
        diff += abs(digitA - digitB)
        a /= 10
        b /= 10
    }
    return diff
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}