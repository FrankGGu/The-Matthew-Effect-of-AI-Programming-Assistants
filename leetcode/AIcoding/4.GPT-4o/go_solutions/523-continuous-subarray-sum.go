func checkSubarraySum(nums []int, k int) bool {
    if len(nums) < 2 {
        return false
    }

    sumMap := make(map[int]int)
    sumMap[0] = -1
    sum := 0

    for i, num := range nums {
        sum += num
        if k != 0 {
            sum = sum % k
        }

        if index, found := sumMap[sum]; found {
            if i - index > 1 {
                return true
            }
        } else {
            sumMap[sum] = i
        }
    }

    return false
}