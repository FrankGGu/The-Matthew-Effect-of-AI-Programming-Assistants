func getPermutationDifference(s1 string, s2 string) int {
    if len(s1) != len(s2) {
        return -1
    }

    count := make([]int, 26)
    for i := 0; i < len(s1); i++ {
        count[s1[i]-'a']++
        count[s2[i]-'a']--
    }

    diff := 0
    for _, c := range count {
        if c != 0 {
            diff += abs(c)
        }
    }

    return diff / 2
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}