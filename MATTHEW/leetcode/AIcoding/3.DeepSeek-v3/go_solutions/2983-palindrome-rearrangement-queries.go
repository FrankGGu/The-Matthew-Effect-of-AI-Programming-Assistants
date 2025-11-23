func canMakePalindromeQueries(s string, queries [][]int) []bool {
    n := len(s)
    res := make([]bool, len(queries))
    for i, q := range queries {
        a, b, c, d := q[0], q[1], q[2], q[3]
        s1 := s[:a] + s[c:d+1] + s[b+1:c] + s[a:b+1] + s[d+1:]
        res[i] = isPalindromePossible(s1)
    }
    return res
}

func isPalindromePossible(s string) bool {
    cnt := make([]int, 26)
    for _, ch := range s {
        cnt[ch-'a']++
    }
    odd := 0
    for _, v := range cnt {
        if v%2 != 0 {
            odd++
        }
    }
    return odd <= 1
}