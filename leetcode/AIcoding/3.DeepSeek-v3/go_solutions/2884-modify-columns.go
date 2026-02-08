import "strings"

func modifyColumns(data [][]string) [][]string {
    if len(data) == 0 {
        return data
    }

    for i := 1; i < len(data); i++ {
        data[i][1] = strings.ToLower(data[i][1])
    }

    return data
}