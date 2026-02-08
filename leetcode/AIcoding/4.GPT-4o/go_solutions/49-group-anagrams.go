func groupAnagrams(strs []string) [][]string {
    anagrams := make(map[string][]string)

    for _, str := range strs {
        count := [26]int{}
        for _, ch := range str {
            count[ch-'a']++
        }
        key := string(count[:])
        anagrams[key] = append(anagrams[key], str)
    }

    result := make([][]string, 0, len(anagrams))
    for _, group := range anagrams {
        result = append(result, group)
    }

    return result
}