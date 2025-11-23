import "sort"

func successfulPairs(spells []int, potions []int, success int64) []int {
    sort.Ints(potions)
    n := len(potions)
    res := make([]int, len(spells))
    for i, s := range spells {
        left, right := 0, n
        for left < right {
            mid := left + (right-left)/2
            if int64(s)*int64(potions[mid]) >= success {
                right = mid
            } else {
                left = mid + 1
            }
        }
        res[i] = n - left
    }
    return res
}