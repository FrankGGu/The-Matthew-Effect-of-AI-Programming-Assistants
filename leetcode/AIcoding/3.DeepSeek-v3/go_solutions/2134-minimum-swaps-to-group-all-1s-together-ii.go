func minSwaps(nums []int) int {
    ones := 0
    for _, num := range nums {
        if num == 1 {
            ones++
        }
    }
    if ones == 0 {
        return 0
    }

    n := len(nums)
    maxOnes := 0
    currentOnes := 0

    for i := 0; i < ones; i++ {
        if nums[i] == 1 {
            currentOnes++
        }
    }
    maxOnes = currentOnes

    for i := 1; i < n; i++ {
        left := (i - 1) % n
        right := (i + ones - 1) % n

        if nums[left] == 1 {
            currentOnes--
        }
        if nums[right] == 1 {
            currentOnes++
        }

        if currentOnes > maxOnes {
            maxOnes = currentOnes
        }
    }

    return ones - maxOnes
}