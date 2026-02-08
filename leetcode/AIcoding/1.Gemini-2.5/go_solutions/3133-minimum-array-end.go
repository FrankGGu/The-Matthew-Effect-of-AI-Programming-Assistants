func minEnd(n int, x int) int {
    ans := x
    k := n - 1

    // bitPos iterates through the bit positions of x and ans
    // kBitPos iterates through the bit positions of k (which is n-1)
    bitPos := 0
    kBitPos :=