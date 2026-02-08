func xorTriplets(nums []int) int {
    n := len(nums)
    count := 0

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            for k := j + 1; k < n; k++ {
                if (nums[i] ^ nums[j] ^ nums[k]) == 0 {
                    count++
                }
            }
        }
    }

    return count
}