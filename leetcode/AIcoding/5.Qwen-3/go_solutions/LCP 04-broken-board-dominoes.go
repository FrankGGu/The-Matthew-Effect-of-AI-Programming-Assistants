package main

func minDominoRotations(row1 []int, row2 []int) int {
    n := len(row1)
    count1 := [7]int{}
    count2 := [7]int{}
    same := [7]int{}

    for i := 0; i < n; i++ {
        count1[row1[i]]++
        count2[row2[i]]++
        if row1[i] == row2[i] {
            same[row1[i]]++
        }
    }

    for i := 1; i <= 6; i++ {
        if count1[i] == n || count2[i] == n {
            return n - same[i]
        }
    }

    return -1
}