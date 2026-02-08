func checkArithmeticSubarrays(nums []int, l []int, r []int) []bool {
    result := make([]bool, len(l))
    for i := 0; i < len(l); i++ {
        subarray := make([]int, r[i]-l[i]+1)
        copy(subarray, nums[l[i]:r[i]+1])
        sort.Ints(subarray)
        diff := subarray[1] - subarray[0]
        isArithmetic := true
        for j := 2; j < len(subarray); j++ {
            if subarray[j]-subarray[j-1] != diff {
                isArithmetic = false
                break
            }
        }
        result[i] = isArithmetic
    }
    return result
}