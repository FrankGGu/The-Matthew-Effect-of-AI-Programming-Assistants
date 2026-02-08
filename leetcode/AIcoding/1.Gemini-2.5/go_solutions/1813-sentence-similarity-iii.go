import "strings"

func areSentencesSimilar(sentence1 string, sentence2 string) bool {
    words1 := strings.Fields(sentence1)
    words2 := strings.Fields(sentence2)

    n1 := len(words1)
    n2 := len(words2)

    // Ensure words1 is the longer or equal