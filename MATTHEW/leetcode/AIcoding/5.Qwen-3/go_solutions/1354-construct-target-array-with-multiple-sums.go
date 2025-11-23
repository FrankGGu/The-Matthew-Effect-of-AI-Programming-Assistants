package main

func possibleDivide(nums []int, k int) bool {
    if len(nums)%k != 0 {
        return false
    }
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    keys := make([]int, 0, len(count))
    for key := range count {
        keys = append(keys, key)
    }
    sort.Ints(keys)
    for _, key := range keys {
        if count[key] == 0 {
            continue
        }
        target := count[key]
        for i := 0; i < k; i++ {
            if count[key+i] < target {
                return false
            }
            count[key+i] -= target
        }
    }
    return true
}