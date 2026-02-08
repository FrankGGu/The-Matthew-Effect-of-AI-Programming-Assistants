func countAlternatingSubarrays(nums []int) int {
    count := 0
    n := len(nums)

    for i := 0; i < n; i++ {
        if nums[i]%2 == 0 {
            length := 1
            for j := i + 1; j < n && nums[j]%2 == 1 {
                length++
                if j+1 < n && nums[j+1]%2 == 0 {
                    count += length
                    length++
                    j++
                }
            }
            count += length
        }
    }

    return count
}