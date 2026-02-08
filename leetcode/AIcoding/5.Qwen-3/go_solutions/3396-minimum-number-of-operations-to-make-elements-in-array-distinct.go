package main

func minOperations(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    var duplicates []int
    for _, v := range count {
        if v > 1 {
            duplicates = append(duplicates, v-1)
        }
    }

    sort.Ints(duplicates)

    res := 0
    for i := 0; i < len(duplicates); i++ {
        res += duplicates[i]
        if i+1 < len(duplicates) {
            duplicates[i+1] += duplicates[i]
        }
    }

    return res
}