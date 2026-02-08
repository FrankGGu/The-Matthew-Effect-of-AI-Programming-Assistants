var largestMultipleOfThree = function(digits) {
    // Sort digits in ascending order to easily pick the smallest for removal
    digits.sort((a, b) => a - b);

    let totalSum = 0;
    const mod1Indices = []; // Stores indices of digits with remainder 1 when divided by 3
    const mod2Indices = []; // Stores indices of digits with remainder 2 when divided by 3

    // Calculate total sum and populate mod1Indices, mod2Indices
    for (let i = 0; i < digits.length; i++) {
        totalSum += digits[i];
        if (digits[i] % 3 === 1) {
            mod1Indices.push(i);
        } else if (digits[i] % 3 === 2) {
            mod2Indices.push(i);
        }
    }

    let indicesToRemove = [];
    const remainder = totalSum % 3;

    if (remainder === 1) {
        // If totalSum % 3 == 1, we need to remove digits whose sum % 3 == 1.
        // Option 1: Remove one digit with remainder 1 (e.g., 1, 4, 7). This is preferred as it removes fewer digits.
        if (mod1Indices.length >= 1) {
            indicesToRemove.push(mod1Indices[0]); // Remove the smallest such digit
        } 
        // Option 2: If no digit with remainder 1, remove two digits with remainder 2 (e.g., 2, 5, 8).
        // (2+2)%3 = 1.
        else if (mod2Indices.length >= 2) {
            indicesToRemove.push(mod2Indices[0]); // Remove the two smallest such digits
            indicesToRemove.push(mod2Indices[1]);
        } 
        // If neither option is possible, no solution can be formed
        else {
            return "";
        }
    } else if (remainder === 2) {
        // If totalSum % 3 == 2, we need to remove digits whose sum % 3 == 2.
        // Option 1: Remove one digit with remainder 2 (e.g., 2, 5, 8). This is preferred.
        if (mod2Indices.length >= 1) {
            indicesToRemove.push(mod2Indices[0]); // Remove the smallest such digit
        } 
        // Option 2: If no digit with remainder 2, remove two digits with remainder 1 (e.g., 1, 4, 7).
        // (1+1)%3 = 2.
        else if (mod1Indices.length >= 2) {
            indicesToRemove.push(mod1Indices[0]); // Remove the two smallest such digits
            indicesToRemove.push(mod1Indices[1]);
        } 
        // If neither option is possible, no solution can be formed
        else {
            return "";
        }
    }

    // Build the final list of digits, excluding those marked for removal
    const finalDigits = [];
    const removedSet = new Set(indicesToRemove);
    for (let i = 0; i < digits.length; i++) {
        if (!removedSet.has(i)) {
            finalDigits.push(digits[i]);
        }
    }

    // Sort in descending order to form the largest possible number
    finalDigits.sort((a, b) => b - a);

    // Handle edge cases:
    // 1. If no digits are left, return an empty string.
    if (finalDigits.length === 0) {
        return "";
    }
    // 2. If the largest digit is 0, it means all remaining digits are 0 (e.g., [0,0,0]).
    // In this case, the largest multiple of three is "0".
    if (finalDigits[0] === 0) {
        return "0";
    }

    // Join the digits to form the result string
    return finalDigits.join('');
};