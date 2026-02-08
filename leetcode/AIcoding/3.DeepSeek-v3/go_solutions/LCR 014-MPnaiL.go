func checkInclusion(s1 string, s2 string) bool {
    n1, n2 := len(s1), len(s2)
    if n1 > n2 {
        return false
    }

    count1 := [26]int{}
    count2 := [26]int{}

    for i := 0; i < n1; i++ {
        count1[s1[i]-'a']++
        count2[s2[i]-'a']++
    }

    matches := 0
    for i := 0; i < 26; i++ {
        if count1[i] == count2[i] {
            matches++
        }
    }

    for i := n1; i < n2; i++ {
        if matches == 26 {
            return true
        }

        left := s2[i-n1] - 'a'
        count2[left]--
        if count2[left] == count1[left] {
            matches++
        } else if count2[left] == count1[left]-1 {
            matches--
        }

        right := s2[i] - 'a'
        count2[right]++
        if count2[right] == count1[right] {
            matches++
        } else if count2[right] == count1[right]+1 {
            matches--
        }
    }

    return matches == 26
}