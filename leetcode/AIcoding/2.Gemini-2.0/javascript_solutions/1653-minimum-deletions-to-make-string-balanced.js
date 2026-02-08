var minimumDeletions = function(s) {
    let aCount = 0;
    let deletions = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === 'a') {
            aCount++;
        } else {
            deletions = Math.min(deletions + 1, aCount);
        }
    }

    return deletions;
};