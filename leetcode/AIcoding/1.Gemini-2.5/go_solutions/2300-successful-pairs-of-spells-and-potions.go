func successfulPairs(spells []int, potions []int, success int64) []int {
    sort.Ints(potions)

    n := len(spells)
    m := len(potions)
    ans := make([]int, n)

    for i := 0; i < n; i++ {
        spell := spells[i]

        // We need to find 'p' such that spell * p >= success
        // p >= success / spell
        // Using integer division for ceiling: (success + spell - 1) / spell
        // Note: spell is int, success is int64.
        // The type of 'minPotionVal' should be int to be compatible with potions slice and sort.SearchInts.
        // max success is 10^5, max spell is 10^5.
        // (10^5 + 10^5 - 1) / 1 = 199999. Fits in int.
        // minPotionVal will also be at most 10^5.
        minPotionVal := int((success + int64(spell) - 1) / int64(spell))

        // Find the index of the first potion that is >= minPotionVal
        // sort.SearchInts returns the index to insert minPotionVal to keep the slice sorted.
        // This index is also the first element >= minPotionVal.
        idx := sort.SearchInts(potions, minPotionVal)

        // The number of successful potions for the current spell is m - idx
        ans[i] = m - idx
    }

    return ans
}