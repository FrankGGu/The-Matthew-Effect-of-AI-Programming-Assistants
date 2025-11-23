func checkInclusion(s1 string, s2 string) bool {
    if len(s1) > len(s2) {
        return false
    }

    count1 := make([]int, 26)
    count2 := make([]int, 26)

    for i := 0; i < len(s1); i++ {
        count1[s1[i]-'a']++
        count2[s2[i]-'a']++
    }

    if count1 == count2 {
        return true
    }

    for i := len(s1); i < len(s2); i++ {
        count2[s2[i]-'a']++
        count2[s2[i-len(s1)]-'a']--

        if count1 == count2 {
            return true
        }
    }

    return false
}