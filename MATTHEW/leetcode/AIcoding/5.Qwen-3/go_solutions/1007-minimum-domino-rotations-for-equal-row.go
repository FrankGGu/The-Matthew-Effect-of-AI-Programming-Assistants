package main

func minDominoRotations(row []int) int {
    n := len(row)
    count := [2]int{0, 0}
    same := [2]bool{true, true}

    for i := 0; i < n; i++ {
        if row[i] != 0 {
            same[0] = false
        }
        if row[i] != 1 {
            same[1] = false
        }
        count[row[i]]++
    }

    if same[0] {
        return 0
    }
    if same[1] {
        return 0
    }

    res := n
    for target := 0; target < 2; target++ {
        if count[target] < n {
            continue
        }
        rotations := 0
        for i := 0; i < n; i++ {
            if row[i] == target {
                continue
            }
            rotations++
        }
        res = min(res, rotations)
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}