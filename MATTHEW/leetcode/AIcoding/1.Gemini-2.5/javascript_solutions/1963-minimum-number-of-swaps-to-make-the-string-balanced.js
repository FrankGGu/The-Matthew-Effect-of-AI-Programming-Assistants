var minSwaps = function(s) {
    let balance = 0;
    let swaps = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '[') {
            balance++;
        } else { // s[i] === ']'
            if (balance > 0) {
                balance--;
            } else {
                // This ']' is problematic as it cannot be matched by a preceding '['.
                // It must be swapped with a '[' from a later position in the string.
                // Each such swap costs 1 operation.
                // When we perform this conceptual swap, the ']' at the current position
                // effectively becomes a '[' for the purpose of balancing the prefix.
                // So, we increment the swap count and adjust the balance.
                swaps++;
                balance++; 
            }
        }
    }

    return swaps;
};