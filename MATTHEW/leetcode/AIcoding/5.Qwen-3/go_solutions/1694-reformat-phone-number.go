package main

func reformatNumber(number string) string {
    var res []rune
    count := 0
    for _, c := range number {
        if c >= '0' && c <= '9' {
            res = append(res, c)
            count++
        }
    }
    i := 0
    for i < len(res) {
        if len(res)-i > 4 {
            res = append(res, ' ')
            i += 3
        } else if len(res)-i == 4 {
            res = append(res, ' ')
            i += 2
        } else {
            i += 1
        }
    }
    return string(res)
}