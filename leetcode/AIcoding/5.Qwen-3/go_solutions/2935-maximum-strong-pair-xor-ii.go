package main

func maximumStrongPairXOR(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    result := 0
    for i := 0; i < 32; i++ {
        mask := result | (1 << uint(i))
        prefixSet := make(map[int]bool)
        for _, num := range nums {
            prefix := num & mask
            if prefixSet[prefix^mask] {
                result = mask
                break
            }
            prefixSet[prefix] = true
        }
    }
    return result
}