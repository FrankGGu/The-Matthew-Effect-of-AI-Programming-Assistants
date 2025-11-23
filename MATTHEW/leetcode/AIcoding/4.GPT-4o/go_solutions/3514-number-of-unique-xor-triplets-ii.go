func countTriplets(nums []int) int {
    count := 0
    seen := make(map[int]struct{})

    for i := 0; i < len(nums); i++ {
        for j := i + 1; j < len(nums); j++ {
            for k := j + 1; k < len(nums); k++ {
                xorValue := nums[i] ^ nums[j] ^ nums[k]
                if _, ok := seen[xorValue]; !ok {
                    seen[xorValue] = struct{}{}
                    count++
                }
            }
        }
    }
    return count
}