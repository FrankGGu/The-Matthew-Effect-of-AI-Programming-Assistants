package main

func maxNumberOfGroups(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    var keys []int
    for k := range count {
        keys = append(keys, k)
    }
    sort.Ints(keys)
    res := 0
    for i := 0; i < len(keys); i++ {
        if count[keys[i]] > res {
            res++
        }
    }
    return res
}