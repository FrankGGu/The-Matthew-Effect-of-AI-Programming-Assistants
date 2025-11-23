package main

func sumEvenAfterQueries(nums []int, queries [][]int) []int {
    evenSum := 0
    for _, num := range nums {
        if num%2 == 0 {
            evenSum += num
        }
    }

    result := make([]int, len(queries))
    for i, query := range queries {
        val, index := query[0], query[1]
        if nums[index]%2 == 0 {
            evenSum -= nums[index]
        }
        nums[index] += val
        if nums[index]%2 == 0 {
            evenSum += nums[index]
        }
        result[i] = evenSum
    }

    return result
}