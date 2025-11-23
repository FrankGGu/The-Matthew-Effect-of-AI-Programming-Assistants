package main

func canBeEqual(target []int, arr []int) bool {
    if len(target) != len(arr) {
        return false
    }
    count := make(map[int]int)
    for i := 0; i < len(target); i++ {
        count[target[i]]++
        count[arr[i]]--
    }
    for _, v := range count {
        if v != 0 {
            return false
        }
    }
    return true
}