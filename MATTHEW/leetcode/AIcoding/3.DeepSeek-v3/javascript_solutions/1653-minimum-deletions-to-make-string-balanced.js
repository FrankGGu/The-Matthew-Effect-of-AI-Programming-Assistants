var minimumDeletions = function(s) {
    let countB = 0;
    let deletions = 0;
    for (let char of s) {
        if (char === 'a') {
            deletions = Math.min(deletions + 1, countB);
        } else {
            countB++;
        }
    }
    return deletions;
};