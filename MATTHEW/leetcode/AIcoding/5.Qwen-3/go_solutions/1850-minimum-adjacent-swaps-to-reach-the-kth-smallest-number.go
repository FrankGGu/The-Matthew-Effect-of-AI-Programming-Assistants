package main

func getMinSwaps(s string, k int) int {
    sBytes := []byte(s)
    n := len(sBytes)
    res := 0

    for i := 0; i < k; i++ {
        for j := n - 1; j > i; j-- {
            if sBytes[j] < sBytes[j-1] {
                sBytes[j], sBytes[j-1] = sBytes[j-1], sBytes[j]
                res++
            }
        }
    }

    return res
}