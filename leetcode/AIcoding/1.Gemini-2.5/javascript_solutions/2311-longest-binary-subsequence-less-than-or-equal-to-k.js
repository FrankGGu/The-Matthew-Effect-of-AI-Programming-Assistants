var longestSubsequence = function(s, k) {
    let zeroCount = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '0') {
            zeroCount++;
        }
    }

    let currentValue = 0;
    let currentLength = zeroCount;

    for (let i = s.length - 1; i >= 0; i--) {
        if (s[i] === '1') {
            let power = currentLength - zeroCount;

            // If the power is 30 or more, 2^power will be greater than or equal to 2^30 (approx 10^9).
            // Since k is at most 10^9, any '1' at this power or higher would make the value exceed k.
            // Also, (1 << power) in JavaScript can result in negative numbers for power >= 31 due to 32-bit signed integer overflow.
            // To prevent this, we break early.
            if (power >= 30) {
                break;
            }

            let valToAdd = (1 << power);

            if (currentValue + valToAdd <= k) {
                currentValue += valToAdd;
                currentLength++;
            } else {
                // If we cannot add this '1', we cannot add any subsequent '1's either
                // because they would correspond to an even higher power (more significant bit)
                // and thus contribute an even larger value.
                break;
            }
        }
    }

    return currentLength;
};