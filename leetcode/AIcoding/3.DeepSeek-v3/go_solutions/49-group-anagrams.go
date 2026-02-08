func groupAnagrams(strs []string) [][]string {
    groups := make(map[[26]int][]string)

    for _, s := range strs {
        count := [26]int{}
        for _, c := range s {
            count[c-'a']++
        }
        groups[count] = append(groups[count], s)
    }

    result := make([][]string, 0, len(groups))
    for _, v := range groups {
        result = append(result, v)
    }
    return result
}