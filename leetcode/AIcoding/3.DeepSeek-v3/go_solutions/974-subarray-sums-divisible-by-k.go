func subarraysDivByK(nums []int, k int) int {
    prefixMod := 0
    result := 0
    modGroups := make([]int, k)
    modGroups[0] = 1

    for _, num := range nums {
        prefixMod = (prefixMod + num % k + k) % k
        result += modGroups[prefixMod]
        modGroups[prefixMod]++
    }

    return result
}