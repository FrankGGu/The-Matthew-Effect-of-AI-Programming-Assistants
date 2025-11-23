func singleNumber(nums []int) []int {
    xorSum := 0
    for _, num := range nums {
        xorSum ^= num
    }

    // Find the rightmost set bit in xorSum
    // This bit is guaranteed to be set because the two single numbers are different.
    // This bit will distinguish the two single numbers.
    diff := xorSum & (-xorSum)

    a := 0
    b := 0

    // Partition the numbers into two groups based on the 'diff' bit
    // One group will contain one single number, the other group will contain the other.
    // All duplicate numbers will fall into the same group as their pair.
    for _, num := range nums {
        if (num & diff) != 0 {
            a ^= num
        } else {
            b ^= num
        }
    }

    return []int{a, b}
}