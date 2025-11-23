func canBeEqual(s1 string, s2 string) bool {
    if s1 == s2 {
        return true
    }
    s1Arr := []byte(s1)
    s2Arr := []byte(s2)

    if s1Arr[0] == s2Arr[2] && s1Arr[2] == s2Arr[0] {
        s1Arr[0], s1Arr[2] = s1Arr[2], s1Arr[0]
    }

    if s1Arr[1] == s2Arr[3] && s1Arr[3] == s2Arr[1] {
        s1Arr[1], s1Arr[3] = s1Arr[3], s1Arr[1]
    }

    return string(s1Arr) == s2
}