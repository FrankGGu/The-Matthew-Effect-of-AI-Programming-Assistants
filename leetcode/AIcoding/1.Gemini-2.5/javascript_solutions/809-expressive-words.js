var expressiveWords = function(s, words) {
    let count = 0;

    function isStretchy(s, word) {
        let i = 0; // Pointer for s
        let j = 0; // Pointer for word

        while (i < s.length && j < word.length) {
            if (s[i] !== word[j]) {
                return false;
            }

            // Count consecutive characters for s
            let char_s = s[i];
            let count_s = 0;
            let k = i;
            while (k < s.length && s[k] === char_s) {
                count_s++;
                k++;
            }

            // Count consecutive characters for word
            let char_w = word[j]; // Should be same as char_s
            let count_w = 0;
            let l = j;
            while (l < word.length && word[l] === char_w) {
                count_w++;
                l++;
            }

            // Apply conditions for stretchy
            // 1. The group in s cannot be shorter than the group in word
            if (count_s < count_w) {
                return false;
            }
            // 2. If the group in s is longer than the group in word,
            //    the group in s must be "stretchy" (i.e., length >= 3)
            if (count_s > count_w && count_s < 3) {
                return false;
            }

            // Advance pointers to the start of the next group
            i = k;
            j = l;
        }

        // After the loop, both pointers must have reached the end of their respective strings
        return i === s.length && j === word.length;
    }

    for (const word of words) {
        if (isStretchy(s, word)) {
            count++;
        }
    }

    return count;
};