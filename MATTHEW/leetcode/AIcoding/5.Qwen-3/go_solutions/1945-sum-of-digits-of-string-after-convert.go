package main

func getLucky(s string, k int) int {
    var numStr string
    for _, c := range s {
        numStr += strconv.Itoa(int(c - 'a' + 1))
    }
    for k > 0 {
        sum := 0
        for _, ch := range numStr {
            sum += int(ch - '0')
        }
        numStr = strconv.Itoa(sum)
        k--
    }
    return strconv.Atoi(numStr)
}