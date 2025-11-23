func minMovesToMakePalindrome(s string) int {
    res := 0
    str := []byte(s)
    left, right := 0, len(str)-1

    for left < right {
        if str[left] == str[right] {
            left++
            right--
            continue
        }

        k := right
        for k > left && str[k] != str[left] {
            k--
        }

        if k == left {
            res += len(str)/2 - left
            left++
        } else {
            for k < right {
                str[k], str[k+1] = str[k+1], str[k]
                res++
                k++
            }
            left++
            right--
        }
    }

    return res
}