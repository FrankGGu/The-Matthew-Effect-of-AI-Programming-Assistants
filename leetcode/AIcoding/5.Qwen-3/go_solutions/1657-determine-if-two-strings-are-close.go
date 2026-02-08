package main

func closeStrings(word1 string, word2 string) bool {
    if len(word1) != len(word2) {
        return false
    }

    count1 := make(map[rune]int)
    count2 := make(map[rune]int)

    for _, c := range word1 {
        count1[c]++
    }

    for _, c := range word2 {
        count2[c]++
    }

    if len(count1) != len(count2) {
        return false
    }

    freq1 := make(map[int]int)
    freq2 := make(map[int]int)

    for _, v := range count1 {
        freq1[v]++
    }

    for _, v := range count2 {
        freq2[v]++
    }

    return reflect.DeepEqual(freq1, freq2)
}