var findAnagrams = function(s, p) {
    const result = [];
    if (s.length < p.length) {
        return result;
    }

    const pMap = new Array(26).fill(0);
    for (let i = 0; i < p.length; i++) {
        pMap[p.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let left = 0;
    let right = 0;
    let count = 0; // This tracks how many characters in the current window satisfy the frequency requirement of 'p'.

    while (right < s.length) {
        const charR_code = s.charCodeAt(right) - 'a'.charCodeAt(0);

        // If the character at 'right' is one that 'p' needs (its count in pMap is > 0),
        // it means this character contributes to forming an anagram. Increment 'count'.
        if (pMap[charR_code] > 0) {
            count++;
        }
        // Decrement its count in pMap. This signifies that we've "used" one instance of this character.
        // If pMap[charR_code] becomes negative, it means we have an excess of this character in the window.
        pMap[charR_code]--;

        // If the current window size is equal to p.length, check for an anagram.
        if (right - left + 1 === p.length) {
            // If 'count' equals p.length, it means all characters in the current window
            // are needed by 'p' and their frequencies match exactly.
            if (count === p.length) {
                result.push(left);
            }

            // Prepare to shrink the window from the 'left'.
            const charL_code = s.charCodeAt(left) - 'a'.charCodeAt(0);

            // Increment its count in pMap, effectively "returning" it to the pool of needed characters.
            pMap[charL_code]++;

            // If, after incrementing, pMap[charL_code] is now > 0, it means this character
            // was previously a "valid" match (i.e., its count was 0 before incrementing).
            // Since we are removing it, it no longer contributes to 'count'.
            if (pMap[charL_code] > 0) {
                count--;
            }
            // Move the left pointer to shrink the window.
            left++;
        }
        // Move the right pointer to expand the window.
        right++;
    }

    return result;
};