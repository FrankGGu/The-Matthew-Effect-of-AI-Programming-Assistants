func numDupDigitsAtMostN(N int) int {
    strN := strconv.Itoa(N)
    lenN := len(strN)
    count := 0

    for i := 1; i < lenN; i++ {
        count += 9 * permutation(9, i-1)
    }

    seen := make(map[int]bool)
    for i := 0; i < lenN; i++ {
        for j := 0; j < int(strN[i]-'0'); j++ {
            if i == 0 && j == 0 {
                continue
            }
            if !seen[j] {
                count += permutation(9-i, lenN-i-1)
            }
        }
        if seen[int(strN[i]-'0')] {
            break
        }
        seen[int(strN[i]-'0')] = true
    }

    return N - count
}

func permutation(n, k int) int {
    result := 1
    for i := 0; i < k; i++ {
        result *= n - i
    }
    return result
}