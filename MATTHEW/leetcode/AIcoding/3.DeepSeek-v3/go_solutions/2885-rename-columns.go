import "strings"

func renameColumns(data [][]string, names []string) [][]string {
    if len(data) == 0 {
        return data
    }
    for i := 0; i < len(data[0]); i++ {
        if i < len(names) {
            data[0][i] = names[i]
        }
    }
    return data
}