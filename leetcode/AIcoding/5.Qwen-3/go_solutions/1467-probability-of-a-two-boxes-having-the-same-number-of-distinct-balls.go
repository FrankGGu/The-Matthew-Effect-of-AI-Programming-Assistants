package main

func numberOfWays(strs string) int {
    count := make(map[byte]int)
    for i := 0; i < len(strs); i++ {
        count[strs[i]]++
    }
    var res int
    for k := range count {
        res += count[k]
    }
    return res
}