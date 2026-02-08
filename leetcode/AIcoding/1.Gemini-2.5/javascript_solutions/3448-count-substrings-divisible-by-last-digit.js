function countSubstringsDivisibleByLastDigit(s) {
    let count = 0;
    const n = s.length;

    // Iterate through all possible ending positions 'j' for a substring
    for (let j = 0; j < n; j++) {
        const divisor = parseInt(s[j]);

        // If the last digit is '0', it cannot be a divisor.
        // Any substring ending at 'j' will not count.
        if (divisor === 0) {
            continue;
        }

        // currentSubstringValModDivisor will store (value of s[k...j]) % divisor
        // currentPowerOf10 will store (10^(j-k)) % divisor
        let currentSubstringValModDivisor = 0;
        let currentPowerOf10 = 1;

        // Iterate backwards from 'k=j' to 'k=0' to form substrings s[k...j]
        // For each 'k', s[k...j] is a substring ending at 'j'.
        for (let k = j; k >= 0; k--) {
            const digit_s_k = parseInt(s[k]);

            // Calculate the value of s[k...j] modulo 'divisor'.
            // The value of s[k...j] can be expressed as:
            // digit_s_k * 10^(j-k) + value(s[k+1...j])
            //
            // In this loop, 'currentPowerOf10' holds 10^(j-k) % divisor for the current 'k'.
            // 'currentSubstringValModDivisor' (from the previous iteration k+1) holds value(s[k+1...j]) % divisor.
            // So, we update it:
            currentSubstringValModDivisor = (digit_s_k * currentPowerOf10 + currentSubstringValModDivisor) % divisor;

            // If the substring value modulo its last digit (divisor) is 0, increment count.
            if (currentSubstringValModDivisor === 0) {
                count++;
            }

            // Update currentPowerOf10 for the next iteration (k-1).
            // For s[k-1...j], the power of 10 for s[k-1] will be 10^(j-(k-1)) = 10^(j-k+1).
            // This is simply (currentPowerOf10 * 10) % divisor.
            currentPowerOf10 = (currentPowerOf10 * 10) % divisor;
        }
    }

    return count;
}