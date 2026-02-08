func getMaximumConsecutive(coins []int) int {
    sort.Ints(coins)

    reachable := 1 // Represents that we can form all values from 0 up to `reachable - 1`.
                   // Initially, we can form 0, so `reachable` is 1.