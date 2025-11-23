function minimumDeletions(s) {
    let countA = 0, countB = 0;
    for (const char of s) {
        if (char === 'a') {
            countA++;
        } else {
            countB++;
        }
    }
    return Math.min(countA, countB);
}