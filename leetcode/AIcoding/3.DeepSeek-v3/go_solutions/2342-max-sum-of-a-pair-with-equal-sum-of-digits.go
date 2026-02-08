func maximumSum(nums []int) int {
    digitSumMap := make(map[int][]int)
    maxSum := -1

    for _, num := range nums {
        sum := 0
        n := num
        for n > 0 {
            sum += n % 10
            n /= 10
        }
        digitSumMap[sum] = append(digitSumMap[sum], num)
    }

    for _, list := range digitSumMap {
        if len(list) >= 2 {
            sort.Sort(sort.Reverse(sort.IntSlice(list)))
            currentSum := list[0] + list[1]
            if currentSum > maxSum {
                maxSum = currentSum
            }
        }
    }

    return maxSum
}