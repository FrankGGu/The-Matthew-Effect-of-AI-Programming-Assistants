var smallestSubsequence = function(s, k, letter, occurrence) {
    const n = s.length;
    const stack = [];
    let letterCountInStack = 0;

    let totalLetterCountInS = 0;
    for (let i = 0; i < n; i++) {
        if (s[i] === letter) {
            totalLetterCountInS++;
        }
    }

    let removals = n - k;

    for (let i = 0; i < n; i++) {
        const char = s[i];

        // Decrement totalLetterCountInS for characters after current index i
        if (char === letter) {
            totalLetterCountInS--;
        }

        // Pop phase: Remove elements from stack if they are greater than current char
        // and we can afford to remove them (removals budget, length, and occurrence constraints)
        while (stack.length > 0 && removals > 0 && stack[stack.length - 1] > char) {
            // Check if popping stack.top (which is a letter) would violate occurrence constraint
            if (stack[stack.length - 1] === letter && letterCountInStack - 1 + totalLetterCountInS < occurrence) {
                break; // Cannot pop this letter
            }

            const poppedChar = stack.pop();
            if (poppedChar === letter) {
                letterCountInStack--;
            }
            removals--;
        }

        // Push phase: Add current char to stack
        // If char is the required letter
        if (char === letter) {
            stack.push(char);
            letterCountInStack++;
        } 
        // If char is not the required letter
        else {
            // Only push if we can still satisfy the occurrence constraint with remaining letters
            // (letters already in stack + letters available in the rest of the string)
            if (letterCountInStack + totalLetterCountInS >= occurrence) {
                stack.push(char);
            } else {
                // If we cannot push this non-letter without violating occurrence,
                // it's implicitly removed. This counts towards our removals budget.
                removals--;
            }
        }
    }

    // After iterating through s, the stack might still be longer than k
    // Trim the stack from the end until its length is k
    while (stack.length > k) {
        const poppedChar = stack.pop();
        if (poppedChar === letter) {
            letterCountInStack--;
        }
    }

    // The stack now contains the smallest k-length subsequence.
    // It should also satisfy the occurrence constraint due to the logic above.
    return stack.join('');
};