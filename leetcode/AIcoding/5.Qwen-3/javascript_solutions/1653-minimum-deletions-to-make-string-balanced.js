function minimumDeletions(s) {
    let n = s.length;
    let leftB = 0;
    let rightA = 0;

    for (let i = 0; i < n; i++) {
        if (s[i] === 'a') rightA++;
    }

    let minDeletions = rightA;

    for (let i = 0; i < n; i++) {
        if (s[i] === 'a') {
            rightA--;
        } else {
            leftB++;
        }

        minDeletions = Math.min(minDeletions, leftB + rightA);
    }

    return minDeletions;
}