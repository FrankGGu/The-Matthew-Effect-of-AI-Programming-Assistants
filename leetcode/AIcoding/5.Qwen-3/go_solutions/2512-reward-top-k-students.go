package main

func topStudents(questions []string, hits []int, k int) []string {
    wordMap := make(map[string]int)
    for i := 0; i < len(questions); i++ {
        wordMap[questions[i]] = hits[i]
    }

    type Pair struct {
        word  string
        score int
    }

    var pairs []Pair
    for word, score := range wordMap {
        pairs = append(pairs, Pair{word, score})
    }

    sort.Slice(pairs, func(i, j int) bool {
        if pairs[i].score != pairs[j].score {
            return pairs[i].score > pairs[j].score
        }
        return pairs[i].word < pairs[j].word
    })

    result := make([]string, 0, k)
    for i := 0; i < k && i < len(pairs); i++ {
        result = append(result, pairs[i].word)
    }

    return result
}