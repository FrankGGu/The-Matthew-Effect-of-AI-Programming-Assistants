func groupAnagrams(strs []string) [][]string {
    anagramMap := make(map[[26]int][]string)

    for _, str := range strs {
        count := [26]int{}
        for _, char := range str {
            count[char-'a']++
        }
        anagramMap[count] = append(anagramMap[count], str)
    }

    result := [][]string{}
    for _, group := range anagramMap {
        result = append(result, group)
    }

    return result
}