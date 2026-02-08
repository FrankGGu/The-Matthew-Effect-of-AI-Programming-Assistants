import "strconv"
import "strings"

func maximum69Number (num int) int {
    s := strconv.Itoa(num)
    runes := []rune(s)

    for i, r := range runes {
        if r == '6' {
            runes[i] = '9'
            break
        }
    }

    res, _ := strconv.Atoi(string(runes))
    return res
}