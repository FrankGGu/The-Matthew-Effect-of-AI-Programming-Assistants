package main

func groupAnagrams(strs []string) [][]string {
    anagramMap := make(map[[26]int][]string)
    for _, str := range strs {
        var count [26]int
        for _, c := range str {
            count[c-'a']++
        }
        anagramMap[count] = append(anagramMap[count], str)
    }
    result := make([][]string, 0, len(anagramMap))
    for _, v := range anagramMap {
        result = append(result, v)
    }
    return result
}