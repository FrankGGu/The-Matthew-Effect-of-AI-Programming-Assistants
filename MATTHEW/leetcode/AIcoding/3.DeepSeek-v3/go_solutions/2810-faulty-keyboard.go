func finalString(s string) string {
    var result []byte
    for i := 0; i < len(s); i++ {
        if s[i] == 'i' {
            reverseBytes(result)
        } else {
            result = append(result, s[i])
        }
    }
    return string(result)
}

func reverseBytes(arr []byte) {
    left, right := 0, len(arr)-1
    for left < right {
        arr[left], arr[right] = arr[right], arr[left]
        left++
        right--
    }
}