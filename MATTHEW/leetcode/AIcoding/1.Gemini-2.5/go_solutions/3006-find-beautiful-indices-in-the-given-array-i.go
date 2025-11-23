func findBeautifulIndices(s string, a string, b string, k int) []int {
    n := len(s)
    lenA := len(a)
    lenB := len(b)

    var indicesA []int
    if lenA > 0 {
        for i := 0; i <= n-lenA; i++ {
            if s[i:i+lenA] == a {
                indicesA = append(indicesA, i)
            }
        }
    }

    var indicesB []int
    if lenB > 0 {
        for j := 0; j <= n-lenB; j++ {
            if s[j:j+lenB] == b {
                indicesB = append(indicesB, j)
            }
        }
    }

    var result []int
    for _, idxA := range indicesA {
        for _, idxB := range indicesB {
            diff := idxA - idxB
            if diff < 0 {
                diff = -diff
            }

            if diff <= k {
                result = append(result, idxA)
                break
            }
        }
    }

    return result
}