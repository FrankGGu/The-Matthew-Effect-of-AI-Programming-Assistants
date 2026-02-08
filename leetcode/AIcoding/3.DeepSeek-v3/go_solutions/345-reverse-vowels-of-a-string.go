func reverseVowels(s string) string {
    vowels := map[byte]bool{
        'a': true, 'e': true, 'i': true, 'o': true, 'u': true,
        'A': true, 'E': true, 'I': true, 'O': true, 'U': true,
    }
    bytes := []byte(s)
    left, right := 0, len(bytes)-1
    for left < right {
        for left < right && !vowels[bytes[left]] {
            left++
        }
        for left < right && !vowels[bytes[right]] {
            right--
        }
        bytes[left], bytes[right] = bytes[right], bytes[left]
        left++
        right--
    }
    return string(bytes)
}