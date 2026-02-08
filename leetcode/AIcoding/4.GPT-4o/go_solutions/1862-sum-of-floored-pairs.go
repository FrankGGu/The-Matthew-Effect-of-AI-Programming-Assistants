func sumOfFlooredPairs(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    count := make([]int, maxNum+1)
    for _, num := range nums {
        count[num]++
    }

    result := 0
    for i := 1; i <= maxNum; i++ {
        for j := i; j <= maxNum; j += i {
            result += count[j] * i
        }
    }

    return result
}