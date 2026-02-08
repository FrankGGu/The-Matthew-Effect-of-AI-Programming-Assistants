package main

func maxOverlap(a, b [][]int) int {
    n := len(a)
    offsetMap := make(map[[2]int]int)
    for i1 := 0; i1 < n; i1++ {
        for j1 := 0; j1 < n; j1++ {
            if a[i1][j1] == 1 {
                for i2 := 0; i2 < n; i2++ {
                    for j2 := 0; j2 < n; j2++ {
                        if b[i2][j2] == 1 {
                            dx := i2 - i1
                            dy := j2 - j1
                            offsetMap[[2]int{dx, dy}]++
                        }
                    }
                }
            }
        }
    }
    max := 0
    for _, count := range offsetMap {
        if count > max {
            max = count
        }
    }
    return max
}

func largestOverlap(s1 [][]int, s2 [][]int) int {
    return maxOverlap(s1, s2)
}