func minimumOneBitOperations(n int) int {
    if n == 0 {
        return 0
    }

    // Find the most significant bit (MSB) position
    // log2(n) gives the floor of the logarithm base 2.
    // For n=1, log2(1)=0,