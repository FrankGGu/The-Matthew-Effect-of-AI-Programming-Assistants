var findMaximumXOR = function(nums) {
    let maxXOR = 0;
    let mask = 0;

    // Iterate from the most significant bit (30) down to 0.
    // Numbers are up to 2 * 10^9, which is less than 2^31.
    // So, we consider bits from 30 down to 0.
    for (let i = 30; i >= 0; i--) {
        // Update the mask to include the current bit and all more significant bits.
        // For example, if i=30, mask will be 1<<30.
        // If i=29, mask will be (1<<30) | (1<<29).
        mask = mask | (1 << i);

        // Create a set to store prefixes of numbers up to the current bit.
        // A prefix of a number 'num' at bit 'i' is 'num & mask'.
        const prefixes = new Set();
        for (const num of nums) {
            prefixes.add(num & mask);
        }

        // We are trying to achieve a potential new maximum XOR.
        // If the current maxXOR is X, we try to see if we can make it X | (1 << i).
        // This means we are trying to make the i-th bit of maxXOR a 1.
        const potentialMaxXOR = maxXOR | (1 << i);

        // Check if there are two prefixes in the set whose XOR equals potentialMaxXOR.
        // Let's say we have two numbers, A and B.
        // We are looking for prefixes A_prefix and B_prefix such that:
        // A_prefix = A & mask
        // B_prefix = B & mask
        // And (A & mask) ^ (B & mask) === potentialMaxXOR
        // This is equivalent to checking if for any A_prefix in `prefixes`,
        // `potentialMaxXOR ^ A_prefix` also exists in `prefixes`.
        for (const p of prefixes) {
            if (prefixes.has(potentialMaxXOR ^ p)) {
                maxXOR = potentialMaxXOR;
                break; // Found a pair that achieves this bit, move to the next less significant bit.
            }
        }
    }

    return maxXOR;
};