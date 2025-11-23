func canBeEqual(target string, arr []string) bool {
    if len(target) != len(arr) {
        return false
    }

    count := make(map[rune]int)
    for _, char := range target {
        count[char]++
    }

    for _, str := range arr {
        for _, char := range str {
            count[char]--
        }
    }

    for _, v := range count {
        if v != 0 {
            return false
        }
    }

    return true
}