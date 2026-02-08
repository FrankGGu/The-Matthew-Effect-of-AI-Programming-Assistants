func countCompleteSubstrings(word string, k int) int {
    n := len(word)
    res := 0
    for i := 0; i < n; {
        start := i
        i++
        for i < n && abs(int(word[i])-int(word[i-1])) <= 2 {
            i++
        }
        res += helper(word[start:i], k)
    }
    return res
}

func helper(s string, k int) int {
    res := 0
    n := len(s)
    for unique := 1; unique <= 26; unique++ {
        if unique*k > n {
            break
        }
        cnt := [26]int{}
        left := 0
        currentUnique := 0
        valid := 0
        for right := 0; right < n; right++ {
            c := int(s[right] - 'a')
            if cnt[c] == 0 {
                currentUnique++
            }
            cnt[c]++
            if cnt[c] == k {
                valid++
            }
            for currentUnique > unique {
                leftC := int(s[left] - 'a')
                if cnt[leftC] == k {
                    valid--
                }
                cnt[leftC]--
                if cnt[leftC] == 0 {
                    currentUnique--
                }
                left++
            }
            if currentUnique == unique && valid == unique {
                res++
            }
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}