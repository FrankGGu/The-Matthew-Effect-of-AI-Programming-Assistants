package main

func minSubsequence(nums []int) []int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    keys := make([]int, 0, len(count))
    for key := range count {
        keys = append(keys, key)
    }

    sort.Sort(sort.Reverse(sort.IntSlice(keys)))

    result := make([]int, 0)
    sum := 0
    total := 0

    for _, num := range nums {
        total += num
    }

    for _, key := range keys {
        for i := 0; i < count[key]; i++ {
            result = append(result, key)
            sum += key
            if sum > total-sum {
                break
            }
        }
        if sum > total-sum {
            break
        }
    }

    return result
}