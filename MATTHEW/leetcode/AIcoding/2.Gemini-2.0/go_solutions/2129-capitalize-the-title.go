import "strings"

func capitalizeTitle(title string) string {
    words := strings.Split(title, " ")
    result := make([]string, len(words))
    for i, word := range words {
        word = strings.ToLower(word)
        if len(word) <= 2 {
            result[i] = word
        } else {
            result[i] = strings.ToUpper(string(word[0])) + word[1:]
        }
    }
    return strings.Join(result, " ")
}