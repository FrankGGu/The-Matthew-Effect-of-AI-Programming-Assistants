func canMakePaliQueries(s string, queries [][]int) []bool {
    n := len(s)
    prefix := make([][26]int, n+1)

    for i := 0; i < n; i++ {
        for j := 0; j < 26; j++ {
            prefix[i+1][j] = prefix[i][j]
        }
        prefix[i+1][s[i]-'a']++
    }

    result := make([]bool, len(queries))

    for i, query := range queries {
        left, right, k := query[0], query[1], query[2]
        oddCount := 0

        for j := 0; j < 26; j++ {
            if (prefix[right+1][j] - prefix[left][j]) % 2 == 1 {
                oddCount++
            }
        }

        if oddCount/2 <= k {
            result[i] = true
        } else {
            result[i] = false
        }
    }

    return result
}