package main

func toHex(num int) string {
    if num == 0 {
        return "0"
    }
    var result []rune
    hexDigits := "0123456789abcdef"
    for num != 0 {
        result = append(result, rune(hexDigits[num&15]))
        num >>= 4
    }
    for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }
    return string(result)
}