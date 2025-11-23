func minOperations(nums []int, target []int) int {
    res := 0
    for i := 0; i < 32; i++ {
        mask := 1 << i
        sumNums, sumTarget := 0, 0
        for _, num := range nums {
            if num & mask != 0 {
                sumNums++
            }
        }
        for _, t := range target {
            if t & mask != 0 {
                sumTarget++
            }
        }
        if sumNums >= sumTarget {
            continue
        }
        found := false
        for j := i + 1; j < 32; j++ {
            higherMask := 1 << j
            higherSum := 0
            for _, num := range nums {
                if num & higherMask != 0 {
                    higherSum++
                }
            }
            if higherSum > 0 {
                res += j - i
                found = true
                for k := 0; k < len(nums); k++ {
                    if nums[k] & higherMask != 0 {
                        nums[k] ^= higherMask
                        nums[k] |= mask << (j - i)
                    }
                }
                break
            }
        }
        if !found {
            return -1
        }
        i-- 
    }
    return res
}