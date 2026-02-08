package main

func longestAwesome(s string) int {
    mapPrefix := make(map[int]int)
    mapPrefix[0] = -1
    result := 0
    for i, ch := range s {
        bit := int(ch - '0')
        mask := 0
        for k := range mapPrefix {
            mask = k
        }
        mask ^= (1 << bit)
        if val, ok := mapPrefix[mask]; ok {
            result = max(result, i-val)
        } else {
            mapPrefix[mask] = i
        }
        for j := 0; j < 10; j++ {
            temp := mask ^ (1 << j)
            if val, ok := mapPrefix[temp]; ok {
                result = max(result, i-val)
            }
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}