func isSimilar(mat1 [][]int, mat2 [][]int) bool {
    n, m := len(mat1), len(mat1[0])
    if n != len(mat2) || m != len(mat2[0]) {
        return false
    }

    for i := 0; i < n; i++ {
        if isCyclicShiftEqual(mat1[i], mat2[i]) {
            return true
        }
    }
    return false
}

func isCyclicShiftEqual(row1, row2 []int) bool {
    l := len(row1)
    for i := 0; i < l; i++ {
        match := true
        for j := 0; j < l; j++ {
            if row1[j] != row2[(i+j)%l] {
                match = false
                break
            }
        }
        if match {
            return true
        }
    }
    return false
}