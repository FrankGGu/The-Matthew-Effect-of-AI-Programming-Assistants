package main

func decodeSecret(encoded []int, first int) []int {
    n := len(encoded)
    result := make([]int, n+1)
    result[0] = first
    for i := 0; i < n; i++ {
        result[i+1] = result[i] ^ encoded[i]
    }
    return result
}