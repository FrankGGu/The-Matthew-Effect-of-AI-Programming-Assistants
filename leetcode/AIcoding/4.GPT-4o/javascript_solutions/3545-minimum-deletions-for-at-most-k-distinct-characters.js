function minimumDeletions(s, k) {
    const charCount = {};
    for (const char of s) {
        charCount[char] = (charCount[char] || 0) + 1;
    }

    const counts = Object.values(charCount).sort((a, b) => b - a);

    let deletions = 0;
    for (let i = k; i < counts.length; i++) {
        deletions += counts[i];
    }

    return deletions;
}