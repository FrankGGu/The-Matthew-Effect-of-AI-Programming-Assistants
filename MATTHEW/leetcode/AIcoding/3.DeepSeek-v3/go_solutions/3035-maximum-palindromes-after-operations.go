func maxPalindromesAfterOperations(words []string) int {
    count := make([]int, 26)
    lengths := []int{}

    for _, word := range words {
        lengths = append(lengths, len(word))
        for _, c := range word {
            count[c-'a']++
        }
    }

    pairs := 0
    for i := 0; i < 26; i++ {
        pairs += count[i] / 2
    }

    sort.Ints(lengths)
    res := 0

    for _, l := range lengths {
        needPairs := l / 2
        if pairs >= needPairs {
            pairs -= needPairs
            res++
        } else {
            break
        }
    }

    return res
}