package main

func maxRemovals(source string, target string, original string, chars []byte, indices []int) int {
    m, n := len(source), len(target)
    if m < n {
        return 0
    }
    count := make([]int, 256)
    for _, c := range source {
        count[c]++
    }
    for i := 0; i < len(chars); i++ {
        count[chars[i]] -= indices[i]
    }
    res := 0
    for i := 0; i < len(target); i++ {
        if count[target[i]] > 0 {
            res++
            count[target[i]]--
        } else {
            return res
        }
    }
    return res
}