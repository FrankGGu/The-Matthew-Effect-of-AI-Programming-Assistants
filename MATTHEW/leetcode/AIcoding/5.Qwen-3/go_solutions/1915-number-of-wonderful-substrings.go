package main

func wonderfulSubstrings(word string) int {
    count := make(map[int]int)
    count[0] = 1
    result := 0
    for i := 0; i < len(word); i++ {
        mask := 0
        for j := i; j < len(word); j++ {
            mask ^= 1 << (word[j] - 'a')
            if v, ok := count[mask]; ok {
                result += v
            }
            for k := 0; k < 26; k++ {
                if v, ok := count[mask ^ (1 << k)]; ok {
                    result += v
                }
            }
            count[mask]++
        }
    }
    return result
}