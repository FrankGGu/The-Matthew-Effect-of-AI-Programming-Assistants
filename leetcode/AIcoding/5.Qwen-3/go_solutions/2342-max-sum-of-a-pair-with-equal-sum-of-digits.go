package main

func maximumSum(nums []int) int {
    sumMap := make(map[int][]int)
    for _, num := range nums {
        s := 0
        n := num
        for n > 0 {
            s += n % 10
            n /= 10
        }
        sumMap[s] = append(sumMap[s], num)
    }

    maxSum := -1
    for _, list := range sumMap {
        if len(list) >= 2 {
            sort.Ints(list)
            currentSum := list[len(list)-1] + list[len(list)-2]
            if currentSum > maxSum {
                maxSum = currentSum
            }
        }
    }
    return maxSum
}