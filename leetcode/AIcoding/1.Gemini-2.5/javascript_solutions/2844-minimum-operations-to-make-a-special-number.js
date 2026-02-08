var minimumOperations = function(num) {
    const L = num.length;
    let minDeletions = L; // Worst case: delete all digits

    // Check if we can form '0' (which is divisible by 25)
    // If the number contains at least one '0', we can delete all other digits
    // to leave just a '0'. This takes L - 1 operations.
    let hasZero = false;
    for (let i = 0; i < L; i++) {
        if (num[i] === '0') {
            hasZero = true;
            break;
        }
    }
    if (hasZero) {
        minDeletions = L - 1;
    }

    const targets = ["00", "25", "50", "75"];

    for (const target of targets) {
        const d1 = target[0];
        const d2 = target[1];

        let idx2 = -1;
        // Find the rightmost occurrence of d2
        for (let i = L - 1; i >= 0; i--) {
            if (num[i] === d2) {
                idx2 = i;
                break;
            }
        }

        if (idx2 !== -1) { // If d2 is found
            let idx1 = -1;
            // Find the rightmost occurrence of d1 before idx2
            for (let i = idx2 - 1; i >= 0; i--) {
                if (num[i] === d1) {
                    idx1 = i;
                    break;
                }
            }

            if (idx1 !== -1) { // If d1 is found before d2
                // Number of deletions:
                // 1. Digits after idx2: (L - 1 - idx2)
                // 2. Digits between idx1 and idx2: (idx2 - 1 - idx1)
                const currentDeletions = (L - 1 - idx2) + (idx2 - 1 - idx1);
                minDeletions = Math.min(minDeletions, currentDeletions);
            }
        }
    }

    return minDeletions;
};