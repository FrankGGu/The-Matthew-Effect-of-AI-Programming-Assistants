func lastVisitedIntegers(words []string) []int {
    nums := []int{}
    result := []int{}
    k := 0
    for _, word := range words {
        if word == "prev" {
            k++
            if k <= len(nums) {
                result = append(result, nums[len(nums)-k])
            } else {
                result = append(result, -1)
            }
        } else {
            num, _ := strconv.Atoi(word)
            nums = append(nums, num)
            k = 0
        }
    }
    return result
}