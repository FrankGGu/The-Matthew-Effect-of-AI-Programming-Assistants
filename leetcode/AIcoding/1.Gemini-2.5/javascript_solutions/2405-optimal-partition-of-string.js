var partitionString = function(s) {
    let partitions = 0;
    let seenChars = new Set();

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (seenChars.has(char)) {
            partitions++;
            seenChars.clear();
            seenChars.add(char);
        } else {
            seenChars.add(char);
        }
    }

    if (seenChars.size > 0 || s.length === 0) { // Account for the last partition or an empty string case
        partitions++;
    }

    return partitions;
};