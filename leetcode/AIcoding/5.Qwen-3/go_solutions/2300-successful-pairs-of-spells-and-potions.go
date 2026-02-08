package main

func successfulPairs(spells []int, potions []int, success int64) []int {
    n := len(potions)
    sort.Ints(potions)
    result := make([]int, len(spells))

    for i, spell := range spells {
        target := (success + int64(spell-1)) / int64(spell)
        left, right := 0, n
        for left < right {
            mid := left + (right-left)/2
            if int64(potions[mid]) >= target {
                right = mid
            } else {
                left = mid + 1
            }
        }
        result[i] = n - left
    }

    return result
}