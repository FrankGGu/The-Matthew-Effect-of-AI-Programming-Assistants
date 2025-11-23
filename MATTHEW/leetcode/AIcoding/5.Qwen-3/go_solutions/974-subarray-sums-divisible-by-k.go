package main

func subarraysDivByK(nums []int, k int) int {
    count := make(map[int]int)
    count[0] = 1
    prefixMod := 0
    result := 0

    for _, num := range nums {
        prefixMod = (prefixMod + num%k + k) % k
        result += count[prefixMod]
        count[prefixMod]++
    }

    return result
}