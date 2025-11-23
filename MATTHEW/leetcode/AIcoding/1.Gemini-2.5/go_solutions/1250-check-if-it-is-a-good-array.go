func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a % b
    }
    return a
}

func isGoodArray(nums []int) bool {
    if len(nums) == 0 {
        return false // Or handle as per problem constraints, typically nums has at least one element.
    }

    currentGCD := nums[0]
    for i := 1; i < len(nums); i++ {
        currentGCD = gcd(currentGCD, nums[i])
        if currentGCD == 1 {
            return true
        }
    }

    return currentGCD == 1
}