var maximumXorProduct = function(a, b, n) {
    const MOD = 10**9 + 7;

    // Convert a and b to BigInt to handle large numbers (up to 2^60)
    let bigA = BigInt(a);
    let bigB = BigInt(b);

    // A_res_n_bits and B_res_n_bits will store the values of (a XOR x) and (b XOR x)
    // for the lower 'n' bits (from bit 0 to n-1).
    let A_res_n_bits = 0n;
    let B_res_n_bits = 0n;

    // Iterate from the most significant bit (n-1) down to the least significant bit (0)
    // for the 'n' bits that 'x' can influence.
    for (let i = n - 1; i >= 0; i--) {
        const bit_a = (bigA >> BigInt(i)) & 1n;
        const bit_b = (bigB >> BigInt(i)) & 1n;

        if (bit_a === bit_b) {
            // If the i-th bits of 'a' and 'b' are the same:
            // To maximize the numbers, we want the i-th bit of both (a XOR x) and (b XOR x) to be 1.
            // This is achieved by setting x_i = 1 - a_i (or 1 - b_i, since a_i == b_i).
            // In this case, both A_res_n_bits and B_res_n_bits get 1 at bit i.
            A_res_n_bits = A_res_n_bits | (1n << BigInt(i));
            B_res_n_bits = B_res_n_bits | (1n << BigInt(i));
        } else { // bit_a !== bit_b
            // If the i-th bits of 'a' and 'b' are different:
            // For any choice of x_i (0 or 1), one of (a XOR x)_i or (b XOR x)_i will be 0,
            // and the other will be 1.
            // To maximize the product (A * B), we generally want A and B to be as close as possible.
            // We apply a greedy strategy: give the '1' to the currently smaller number
            // (A_res_n_bits or B_res_n_bits) to try and balance them.
            if (A_res_n_bits <= B_res_n_bits) {
                // If A_res_n_bits is smaller or equal, give the '1' to A_res_n_bits.
                // This means (a XOR x)_i = 1.
                // The other number, B_res_n_bits, will get 0 at bit i.
                A_res_n_bits = A_res_n_bits | (1n << BigInt(i));
            } else { // A_res_n_bits > B_res_n_bits
                // If B_res_n_bits is smaller, give the '1' to B_res_n_bits.
                // This means (b XOR x)_i = 1.
                // The other number, A_res_n_bits, will get 0 at bit i.
                B_res_n_bits = B_res_n_bits | (1n << BigInt(i));
            }
        }
    }

    // The problem states 0 <= x < 2^n. This means 'x' can only have bits set
    // from position 0 up to n-1. All bits of 'x' at positions i >= n are 0.
    // Therefore, for bits i >= n:
    // (a XOR x)_i = a_i XOR 0 = a_i
    // (b XOR x)_i = b_i XOR 0 = b_i
    // These higher bits of 'a' and 'b' are fixed and simply carry over to the final result.
    // We need to combine these higher bits with the 'A_res_n_bits' and 'B_res_n_bits'
    // that we computed for the lower 'n' bits.

    // Create a mask for the lower 'n' bits (e.g., for n=3, mask is 0...0111_2)
    const lower_n_bits_mask = (1n << BigInt(n)) - 1n;

    // Extract the higher bits of 'a' and 'b' (bits at or above position n).
    // The bitwise NOT operator (~) on BigInts handles negative numbers correctly
    // in two's complement, which effectively masks out the lower 'n' bits.
    const a_higher_bits = bigA & (~lower_n_bits_mask);
    const b_higher_bits = bigB & (~lower_n_bits_mask);

    // Combine the higher bits with the optimized lower 'n' bits to get the final values.
    const final_A = a_higher_bits | A_res_n_bits;
    const final_B = b_higher_bits | B_res_n_bits;

    // Calculate the product and apply the modulo operation.
    const result = (final_A % BigInt(MOD) * final_B % BigInt(MOD)) % BigInt(MOD);

    // Convert the BigInt result back to a Number for the return type.
    return Number(result);
};