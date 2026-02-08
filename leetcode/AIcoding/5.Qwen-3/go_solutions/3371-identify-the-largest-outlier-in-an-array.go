package main

func largestOustlier(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    maxVal := -1 << 63
    for _, num := range nums {
        if count[num] > 1 {
            count[num]--
            if count[num] == 0 {
                delete(count, num)
            }
            if len(count) == 0 {
                return num
            }
            sum := 0
            for k := range count {
                sum += k
            }
            if num < sum {
                if num > maxVal {
                    maxVal = num
                }
            }
            count[num]++
        }
    }
    return maxVal
}