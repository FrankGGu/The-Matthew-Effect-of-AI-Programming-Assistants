func checkArithmeticSubarrays(nums []int, l []int, r []int) []bool {
    n := len(l)
    results := make([]bool, n)

    for i := 0; i < n; i++ {
        left, right := l[i], r[i]
        subarray := make([]int, right-left+1)
        copy(subarray, nums[left:right+1])
        sort.Ints(subarray)

        diff := subarray[1] - subarray[0]
        isArithmetic := true
        for j := 2; j < len(subarray); j++ {
            if subarray[j]-subarray[j-1] != diff {
                isArithmetic = false
                break
            }
        }
        results[i] = isArithmetic
    }
    return results
}