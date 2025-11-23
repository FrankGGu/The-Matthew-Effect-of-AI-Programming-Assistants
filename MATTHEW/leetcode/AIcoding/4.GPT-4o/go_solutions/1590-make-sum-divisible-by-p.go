func minSubarray(nums []int, p int) int {
    total := 0
    for _, num := range nums {
        total = (total + num) % p
    }

    if total == 0 {
        return 0
    }

    minLength := len(nums) + 1
    prefixSum := make(map[int]int)
    prefixSum[0] = -1
    currSum := 0

    for i, num := range nums {
        currSum = (currSum + num) % p
        prefixSum[currSum] = i

        target := (currSum - total + p) % p
        if idx, found := prefixSum[target]; found {
            minLength = min(minLength, i-idx)
        }
    }

    if minLength == len(nums) + 1 {
        return -1
    }
    return minLength
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}