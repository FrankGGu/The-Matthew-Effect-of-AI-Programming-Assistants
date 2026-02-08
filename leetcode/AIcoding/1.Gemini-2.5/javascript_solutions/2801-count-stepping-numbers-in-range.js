var countSteppingNumbers = function(low, high) {
    const MOD = 10 ** 9 + 7;

    // Helper function to count stepping numbers from 0 to numStr (inclusive)
    const count = (numStr) => {
        const n = numStr.length;
        // memo[index][prevDigit][isTight][isLeadingZero]
        // prevDigit: 0-9 for actual digits. Use 10 as a special value for 'no previous digit' (i.e., when in leading zero state).
        // isTight: boolean, true if we are restricted by numStr's digits (current digit cannot exceed numStr[index])
        // isLeadingZero: boolean, true if we are currently placing leading zeros.
        const memo = new Array(n).fill(0).map(() => 
            new Array(11).fill(0).map(() => // prevDigit can be 0-9, or 10 for 'no prev digit'
                new Array(2).fill(0).map(() => 
                    new Array(2).fill(-1)
                )
            )
        );

        // dp(index, prevDigit, isTight, isLeadingZero)
        // index: current digit position we are considering (0 to n-1)
        // prevDigit: the digit placed at index-1. If isLeadingZero is true, this is 10 (placeholder).
        // isTight: if true, current digit can go from 0 to numStr[index]. If false, 0 to 9.
        // isLeadingZero: if true, we are still placing leading zeros or the first non-zero digit.
        const dp = (index, prevDigit, isTight, isLeadingZero) => {
            if (index === n) {
                // We successfully formed a number.
                // If isLeadingZero is true, it means we only placed zeros (e.g., "000"), which represents the number 0.
                // If isLeadingZero is false, it means we formed a non-zero number.
                // In both cases, it counts as one valid number.
                return 1;
            }

            if (memo[index][prevDigit][isTight][isLeadingZero] !== -1) {
                return memo[index][prevDigit][isTight][isLeadingZero];
            }

            let ans = 0;
            const upperBound = isTight ? parseInt(numStr[index]) : 9;

            for (let digit = 0; digit <= upperBound; digit++) {
                if (isLeadingZero) {
                    // We are placing leading zeros or the first non-zero digit
                    if (digit === 0) {
                        // Still placing leading zeros. prevDigit remains 10.
                        ans = (ans + dp(index + 1, 10, isTight && (digit === upperBound), true)) % MOD;
                    } else {
                        // Placed the first non-zero digit. prevDigit is now 'digit'.
                        ans = (ans + dp(index + 1, digit, isTight && (digit === upperBound), false)) % MOD;
                    }
                } else {
                    // We have already placed a non-zero digit, now check stepping condition
                    if (Math.abs(digit - prevDigit) === 1) {
                        ans = (ans + dp(index + 1, digit, isTight && (digit === upperBound), false)) % MOD;
                    }
                }
            }

            return memo[index][prevDigit][isTight][isLeadingZero] = ans;
        };

        // Initial call:
        // index 0: Start from the first digit.
        // prevDigit 10: Placeholder indicating no previous digit has been placed yet.
        // isTight true: Initially restricted by the digits of numStr.
        // isLeadingZero true: Initially in the leading zero state.
        return dp(0, 10, true, true);
    };

    // Calculate count for high (numbers from 0 to high)
    let countHigh = count(high);

    // Calculate count for low - 1 (numbers from 0 to low-1)
    let countLowMinus1 = 0;
    if (low !== "0") {
        // Convert low to BigInt, subtract 1, convert back to string
        const lowBigInt = BigInt(low);
        const lowMinus1Str = (lowBigInt - 1n).toString();
        countLowMinus1 = count(lowMinus1Str);
    }

    // The problem asks for numbers in [low, high].
    // This is equivalent to (count of numbers up to high) - (count of numbers up to low-1).
    // Add MOD and take modulo again to handle potential negative results from subtraction.
    let result = (countHigh - countLowMinus1 + MOD) % MOD;

    return result;
};