package main

func sortJumbled(arr []int) []int {
    mapping := make(map[int]int)
    for i, num := range arr {
        if _, exists := mapping[num]; !exists {
            mapping[num] = i
        }
    }

    sort.Slice(arr, func(i, j int) bool {
        a, b := arr[i], arr[j]
        if a == b {
            return false
        }
        if a < b {
            return mapping[a] < mapping[b]
        }
        return mapping[b] < mapping[a]
    })

    return arr
}