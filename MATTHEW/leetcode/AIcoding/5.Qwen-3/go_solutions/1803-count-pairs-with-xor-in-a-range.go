package main

func countPairs(nums []int, low int, high int) int {
    var count func([]int, int) int
    count = func(nums []int, x int) int {
        trie := make(map[int]map[int]int)
        res := 0
        for _, num := range nums {
            curr := trie
            for i := 30; i >= 0; i-- {
                bit := (num >> i) & 1
                if next, ok := curr[bit]; ok {
                    curr = next
                } else {
                    curr[bit] = make(map[int]int)
                    curr = curr[bit]
                }
            }
            curr[2]++
        }
        for _, num := range nums {
            curr := trie
            for i := 30; i >= 0; i-- {
                bit := (num >> i) & 1
                targetBit := (x >> i) & 1
                if targetBit == 0 {
                    if next, ok := curr[bit^1]; ok {
                        res += next[2]
                    }
                } else {
                    if next, ok := curr[bit^1]; ok {
                        res += next[2]
                    }
                    if next, ok := curr[bit]; ok {
                        res += next[2]
                    }
                }
                if next, ok := curr[bit]; ok {
                    curr = next
                } else {
                    break
                }
            }
        }
        return res
    }
    return count(nums, high) - count(nums, low-1)
}