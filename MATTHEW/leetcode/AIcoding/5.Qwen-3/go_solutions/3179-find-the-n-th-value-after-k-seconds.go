package main

func kthValueAfterKSeconds(instructions []int, k int) int {
    n := len(instructions)
    res := make([]int, n)
    for i := 0; i < k; i++ {
        temp := make([]int, n)
        for j := 0; j < n; j++ {
            if instructions[j] == 0 {
                temp[j] = 0
            } else {
                temp[j] = res[(j-1+n)%n] + res[j]
            }
        }
        res = temp
    }
    return res[0]
}