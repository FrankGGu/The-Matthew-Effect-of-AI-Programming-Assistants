package main

func canMakeEqual(target string, arr []string) bool {
    if len(target) != len(arr) {
        return false
    }
    var mask byte = 0
    for i := 0; i < len(target); i++ {
        mask ^= target[i]
        for j := 0; j < len(arr[i]); j++ {
            mask ^= arr[i][j]
        }
    }
    return mask == 0
}