func findDupes(nums []int) []int {
    seen := make(map[int]bool)
    dupes := []int{}

    for _, num := range nums {
        if seen[num] {
            dupes = append(dupes, num)
        }
        seen[num] = true
    }

    return dupes
}