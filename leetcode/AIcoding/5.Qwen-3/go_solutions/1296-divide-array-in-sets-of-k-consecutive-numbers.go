package main

func isPossibleDivide(nums []int, k int) bool {
    if len(nums)%k != 0 {
        return false
    }

    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    sort.Ints(nums)

    for _, num := range nums {
        if count[num] == 0 {
            continue
        }
        for i := 0; i < k; i++ {
            if count[num+i] == 0 {
                return false
            }
            count[num+i]--
        }
    }

    return true
}