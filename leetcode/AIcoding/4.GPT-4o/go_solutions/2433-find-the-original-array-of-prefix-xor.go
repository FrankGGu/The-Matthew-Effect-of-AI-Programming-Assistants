func findArray(pref []int) []int {
    n := len(pref)
    if n == 0 {
        return []int{}
    }
    result := make([]int, n)
    result[0] = pref[0]
    for i := 1; i < n; i++ {
        result[i] = pref[i] ^ pref[i-1]
    }
    return result
}