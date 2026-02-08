func reverseOnlyLetters(s string) string {
    n := len(s)
    arr := []rune(s)
    left, right := 0, n-1

    for left < right {
        for left < right && !isLetter(arr[left]) {
            left++
        }
        for left < right && !isLetter(arr[right]) {
            right--
        }

        if left < right {
            arr[left], arr[right] = arr[right], arr[left]
            left++
            right--
        }
    }

    return string(arr)
}

func isLetter(r rune) bool {
    return (r >= 'a' && r <= 'z') || (r >= 'A' && r <= 'Z')
}