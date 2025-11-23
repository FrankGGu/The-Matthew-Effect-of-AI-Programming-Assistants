package main

func largestPalindromic(number string) string {
    count := make([]int, 10)
    for _, c := range number {
        count[int(c-'0')]++
    }

    var left []rune
    var middle rune

    for i := 9; i >= 0; i-- {
        if count[i] > 0 {
            if count[i] >= 2 {
                if i == 0 && len(left) == 0 {
                    continue
                }
                left = append(left, rune(i+'0'))
                count[i] -= 2
            }
        }
    }

    for i := 9; i >= 0; i-- {
        if count[i] > 0 {
            middle = rune(i + '0')
            break
        }
    }

    right := make([]rune, len(left))
    for i := range left {
        right[i] = left[len(left)-1-i]
    }

    result := append(left, right...)
    if middle != 0 {
        result = append(result, middle)
    }

    if len(result) == 0 {
        return "0"
    }

    if len(result) == 1 {
        return string(result)
    }

    for i := 0; i < len(result); i++ {
        if result[i] != '0' {
            return string(result[i:])
        }
    }

    return "0"
}