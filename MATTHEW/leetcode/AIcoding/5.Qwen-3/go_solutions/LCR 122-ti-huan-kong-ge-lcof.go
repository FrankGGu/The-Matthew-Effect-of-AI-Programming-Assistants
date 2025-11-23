package main

func encodePath(path string) string {
    var result []rune
    for _, c := range path {
        if c == '/' {
            result = append(result, '\\')
        }
        result = append(result, c)
    }
    return string(result)
}