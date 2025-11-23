func differenceOfSum(nums []int) int {
    elementSum := 0
    digitSum := 0

    for _, num := range nums {
        elementSum += num

        temp := num
        for temp > 0 {
            digitSum += temp % 10
            temp /= 10
        }
    }

    diff := elementSum - digitSum
    if diff < 0 {
        return -diff
    }
    return diff
}