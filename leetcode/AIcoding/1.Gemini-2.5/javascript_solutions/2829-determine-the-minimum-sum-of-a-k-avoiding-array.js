var minimumSum = function(n, k) {
    let totalSum = 0;
    let pickedCount = 0;

    // Phase 1: Pick numbers 1, 2, ..., m where m = floor((k-1)/2)
    // For any number x in this range, x < k/2, which implies x < k-x.
    // Thus, k-x is a larger number and cannot have been picked yet.
    // These numbers can always be picked without creating a k-avoiding conflict among themselves or with their complements.
    const m = Math.floor((k - 1) / 2);
    const numFromPhase1 = Math.min(n, m);

    // Sum of an arithmetic series: 1 + 2 + ... + numFromPhase1
    totalSum += numFromPhase1 * (numFromPhase1 + 1) / 2;
    pickedCount += numFromPhase1;

    if (pickedCount === n) {
        return totalSum;
    }

    // Phase 2: If k is even and we still need numbers, consider picking k/2.
    // This phase is only relevant if n was large enough to exhaust Phase 1 numbers (i.e., n > m).
    // If k is even, m = k/2 - 1. The number k/2 was not included in Phase 1.
    // k - (k/2) = k/2. Since k/2 itself has not been picked yet, it can be picked.
    // If k is odd, k/2 is not an integer, so this phase is skipped.
    if (k % 2 === 0 && pickedCount < n) {
        totalSum += k / 2;
        pickedCount++;
    }

    if (pickedCount === n) {
        return totalSum;
    }

    // Phase 3: Pick remaining numbers starting from k.
    // For any number x in the range (m, k) (excluding k/2 if k is even),
    // its complement k-x would be in the range [1, m] (or [1, k/2] if k is even and k/2 was picked).
    // Therefore, k-x would have already been picked in Phase 1 (or Phase 2).
    // So, all numbers between the largest picked number so far and k-1 must be skipped.
    // The next available number that does not create a conflict is k (since k-k = 0, which is not a positive integer and thus not picked).
    // Subsequent numbers k+1, k+2, etc., also have non-positive complements (k-(k+j) = -j), so they can always be picked.
    const remainingToPick = n - pickedCount;

    // Sum of an arithmetic series: k + (k+1) + ... + (k + remainingToPick - 1)
    // Sum = count * first_term + count * (count - 1) / 2
    totalSum += remainingToPick * k + remainingToPick * (remainingToPick - 1) / 2;

    return totalSum;
};