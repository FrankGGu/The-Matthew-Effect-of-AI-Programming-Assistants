var maxRepOpt1 = function(s) {
    if (s.length === 0) {
        return 0;
    }

    const totalCounts = {};
    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        totalCounts[char] = (totalCounts[char] || 0) + 1;
    }

    const groups = [];
    let i = 0;
    while (i < s.length) {
        const char = s[i];
        let count = 0;
        let j = i;
        while (j < s.length && s[j] === char) {
            count++;
            j++;
        }
        groups.push([char, count]);
        i = j;
    }

    let maxLen = 0;

    for (let k = 0; k < groups.length; k++) {
        const [char, count] = groups[k];

        // Case 1: Consider the current segment.
        // We can either keep it as is (length 'count'),
        // or if there's another instance of 'char' elsewhere in the string (totalCounts[char] > count),
        // we can swap one character adjacent to this segment with that 'char' to extend this segment by 1.
        // The maximum possible length would be 'count + 1', but it cannot exceed the total occurrences of 'char'.
        maxLen = Math.max(maxLen, Math.min(count + 1, totalCounts[char]));

        // Case 2: Consider merging two segments of the same character separated by exactly one different character.
        // E.g., "aaabaaa" -> groups: [['a',3], ['b',1], ['a',3]]
        if (k + 2 < groups.length) {
            const [nextChar, nextCount] = groups[k + 1];
            const [afterNextChar, afterNextCount] = groups[k + 2];

            if (nextCount === 1 && char === afterNextChar) {
                // We can swap the single character in groups[k+1] with an instance of 'char'
                // from elsewhere (if available) to merge groups[k] and groups[k+2].
                let combinedLength = count + afterNextCount;

                // If total occurrences of 'char' are greater than the combined length,
                // it means we have an extra 'char' available to fill the gap and potentially extend.
                // So, the length becomes combinedLength + 1.
                // Otherwise, if total occurrences are exactly combinedLength, we just get combinedLength.
                maxLen = Math.max(maxLen, Math.min(combinedLength + 1, totalCounts[char]));
            }
        }
    }

    return maxLen;
};