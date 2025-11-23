func differenceOfSum(nums []int) int {
    elementSum := 0
    digitSum := 0

    for _, num := range nums {
        elementSum += num

        n := num
        for n > 0 {
            digitSum += n % 10
            n /= 10
        }
    }

    return elementSum - digitSum
}