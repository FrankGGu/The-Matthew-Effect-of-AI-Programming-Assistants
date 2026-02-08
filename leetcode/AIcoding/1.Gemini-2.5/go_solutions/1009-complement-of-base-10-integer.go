func bitwiseComplement(n int) int {
    if n == 0 {
        return 1
    }

    // Determine the number of bits required to represent n.
    // For example, 5 (101_2) needs 3 bits.
    // 10 (1010_2) needs 4