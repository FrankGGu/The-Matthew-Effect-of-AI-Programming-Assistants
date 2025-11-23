func groupAnagrams(strs []string) [][]string {
    anagrams := make(map[string][]string)

    for _, str := range strs {
        count := make([]int, 26)
        for _, char := range str {
            count[char-'a']++
        }
        key := string(count[:])
        anagrams[key] = append(anagrams[key], str)
    }

    result := [][]string{}
    for _, group := range anagrams {
        result = append(result, group)
    }

    return result
}