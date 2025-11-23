func groupAnagrams(strs []string) [][]string {
    m := make(map[[26]int][]string)
    for _, s := range strs {
        var count [26]int
        for _, c := range s {
            count[c-'a']++
        }
        m[count] = append(m[count], s)
    }
    res := make([][]string, 0, len(m))
    for _, v := range m {
        res = append(res, v)
    }
    return res
}