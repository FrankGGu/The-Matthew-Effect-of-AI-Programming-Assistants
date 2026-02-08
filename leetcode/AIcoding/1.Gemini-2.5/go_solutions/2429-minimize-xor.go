import "math/bits"

func minimizeXor(num1 int, num2 int) int {
    k := bits.OnesCount(uint(num2))
    res := 0

    // Step 1: Try to match set bits of num1 from MSB to LSB
    // This minimizes the XOR value by making x