package main

func checkArithmeticSubarrays(nums []int, l []int, r []int) []bool {
    result := make([]bool, len(l))
    for i := 0; i < len(l); i++ {
        sub := nums[l[i]:r[i]+1]
        if len(sub) < 2 {
            result[i] = true
            continue
        }
        sort.Ints(sub)
        diff := sub[1] - sub[0]
        isArithmetic := true
        for j := 2; j < len(sub); j++ {
            if sub[j]-sub[j-1] != diff {
                isArithmetic = false
                break
            }
        }
        result[i] = isArithmetic
    }
    return result
}