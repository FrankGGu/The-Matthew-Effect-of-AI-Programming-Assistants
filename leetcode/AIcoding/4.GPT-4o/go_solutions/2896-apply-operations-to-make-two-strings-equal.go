func canBeEqual(target string, arr []int) bool {
    if len(target) != len(arr) {
        return false
    }

    count := make(map[rune]int)

    for _, c := range target {
        count[c]++
    }

    for _, num := range arr {
        count[rune(num)]--
    }

    for _, v := range count {
        if v != 0 {
            return false
        }
    }

    return true
}