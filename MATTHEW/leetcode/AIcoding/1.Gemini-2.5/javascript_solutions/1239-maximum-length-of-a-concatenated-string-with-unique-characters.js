var maxLength = function(arr) {
    let validStrings = [];

    // Pre-process strings: convert to bitmasks and filter out strings with duplicate characters
    for (let s of arr) {
        let mask = 0;
        let isUnique = true;
        for (let i = 0; i < s.length; i++) {
            let charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
            if ((mask >> charCode) & 1) { // If bit is already set, character is duplicated
                isUnique = false;
                break;
            }
            mask |= (1 << charCode); // Set the bit for the character
        }
        if (isUnique) {
            validStrings.push({ mask: mask, length: s.length });
        }
    }

    let maxLength = 0;

    // DFS function to explore combinations
    function dfs(index, currentMask, currentLength) {
        maxLength = Math.max(maxLength, currentLength);

        if (index === validStrings.length) {
            return;
        }

        for (let i = index; i < validStrings.length; i++) {
            let nextMask = validStrings[i].mask;
            let nextLength = validStrings[i].length;

            // Check if there are any common characters between currentMask and nextMask
            if ((currentMask & nextMask) === 0) {
                // If no common characters, we can include this string
                dfs(i + 1, currentMask | nextMask, currentLength + nextLength);
            }
            // If common characters exist, we cannot include this string in the current path.
            // The loop will continue to the next string, effectively skipping this one.
        }
    }

    // Start DFS from the beginning with an empty mask and length
    dfs(0, 0, 0);

    return maxLength;
};