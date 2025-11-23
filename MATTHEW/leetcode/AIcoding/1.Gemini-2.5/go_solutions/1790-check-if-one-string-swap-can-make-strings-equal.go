func areAlmostEqual(s1 string, s2 string) bool {
    if len(s1) != len(s2) {
        return false
    }

    diffIndices := []int{}
    for i := 0; i < len(s1); i++ {
        if s1[i] != s2[i] {
            diffIndices = append(diffIndices, i)
        }
    }

    if len(diffIndices) == 0 {
        return true
    }

    if len(diffIndices) == 2 {
        idx1 := diffIndices[0]
        idx2 := diffIndices[1]
        return s1[idx1] == s2[idx2] && s1[idx2] == s2[idx1]
    }

    return false
}