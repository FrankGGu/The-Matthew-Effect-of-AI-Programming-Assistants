package leetcode

func reverseDegree(s string) int {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }
    maxFreq := 0
    for _, v := range count {
        if v > maxFreq {
            maxFreq = v
        }
    }
    return maxFreq
}