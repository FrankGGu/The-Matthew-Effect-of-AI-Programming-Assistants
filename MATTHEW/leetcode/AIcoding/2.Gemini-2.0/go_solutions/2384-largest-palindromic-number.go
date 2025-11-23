func largestPalindromic(num string) string {
    counts := make([]int, 10)
    for _, digit := range num {
        counts[digit-'0']++
    }

    var left []byte
    for i := 9; i >= 0; i-- {
        if i == 0 && len(left) == 0 {
            break
        }
        count := counts[i]
        if count >= 2 {
            repeat := count / 2
            for j := 0; j < repeat; j++ {
                left = append(left, byte('0'+i))
            }
        }
    }

    var middle byte
    for i := 9; i >= 0; i-- {
        if counts[i]%2 == 1 {
            middle = byte('0' + i)
            break
        }
    }

    var right []byte
    for i := len(left) - 1; i >= 0; i-- {
        right = append(right, left[i])
    }

    if len(left) == 0 && middle == 0 {
        return "0"
    }

    result := string(left)
    if middle != 0 {
        result += string(middle)
    }
    result += string(right)

    return result
}