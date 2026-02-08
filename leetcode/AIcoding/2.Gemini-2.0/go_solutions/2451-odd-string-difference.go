func oddString(words []string) string {
    diffs := make([][]int, len(words))
    for i := range words {
        diffs[i] = make([]int, len(words[i])-1)
        for j := 0; j < len(words[i])-1; j++ {
            diffs[i][j] = int(words[i][j+1] - words[i][j])
        }
    }

    if reflect.DeepEqual(diffs[0], diffs[1]) {
        for i := 2; i < len(diffs); i++ {
            if !reflect.DeepEqual(diffs[0], diffs[i]) {
                return words[i]
            }
        }
    } else {
        if reflect.DeepEqual(diffs[0], diffs[2]) {
            return words[1]
        } else {
            return words[0]
        }
    }

    return ""
}
import "reflect"