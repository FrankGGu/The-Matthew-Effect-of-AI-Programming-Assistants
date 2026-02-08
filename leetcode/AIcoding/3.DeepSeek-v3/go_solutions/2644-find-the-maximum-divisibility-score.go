func maxDivScore(nums []int, divisors []int) int {
    maxCount := -1
    result := math.MaxInt32

    for _, d := range divisors {
        count := 0
        for _, num := range nums {
            if num % d == 0 {
                count++
            }
        }
        if count > maxCount || (count == maxCount && d < result) {
            maxCount = count
            result = d
        }
    }

    return result
}