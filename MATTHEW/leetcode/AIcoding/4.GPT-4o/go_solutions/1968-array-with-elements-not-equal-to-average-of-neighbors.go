func rearrangeArray(nums []int) []int {
    n := len(nums)
    result := make([]int, n)

    sort.Ints(nums)

    for i := 0; i < n/2; i++ {
        result[2*i] = nums[i]
        result[2*i+1] = nums[n-i-1]
    }

    if n%2 == 1 {
        result[n-1] = nums[n/2]
    }

    return result
}