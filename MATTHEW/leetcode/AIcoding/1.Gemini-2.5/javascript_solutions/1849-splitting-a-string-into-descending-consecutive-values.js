var splitString = function(s) {
    const n = s.length;

    function backtrack(index, prevVal) {
        if (index === n) {
            return true;
        }

        for (let i = index; i < n; i++) {
            const currentNumStr = s.substring(index, i + 1);
            const currentNum = BigInt(currentNumStr);

            // Optimization: If currentNum is already greater than prevVal - 1,
            // then extending currentNumStr will only make it larger, so break.
            // Since numbers must be strictly decreasing by 1, currentNum cannot be >= prevVal.
            if (currentNum > prevVal - 1n) {
                break;
            }

            if (currentNum === prevVal - 1n) {
                if (backtrack(i + 1, currentNum)) {
                    return true;
                }
            }
        }
        return false;
    }

    // Iterate through all possible first numbers
    // The first number cannot be the entire string, as we need at least two parts.
    // So, the first number can take up to n-1 characters.
    for (let i = 0; i < n - 1; i++) {
        const firstNumStr = s.substring(0, i + 1);
        const firstNum = BigInt(firstNumStr);

        // Start backtracking from the next index with the first number found
        if (backtrack(i + 1, firstNum)) {
            return true;
        }
    }

    return false;
};