package main

func checkIfExist(arr []int) bool {
    seen := make(map[int]bool)
    for _, num := range arr {
        if seen[num*2] || seen[num/2] && num%2 == 0 {
            return true
        }
        seen[num] = true
    }
    return false
}