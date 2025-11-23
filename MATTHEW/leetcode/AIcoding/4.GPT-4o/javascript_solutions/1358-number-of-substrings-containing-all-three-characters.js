var numberOfSubstrings = function(s) {
    let count = 0, left = 0, right = 0;
    const n = s.length;
    const charCount = { 'a': 0, 'b': 0, 'c': 0 };

    while (right < n) {
        charCount[s[right]]++;

        while (charCount['a'] > 0 && charCount['b'] > 0 && charCount['c'] > 0) {
            charCount[s[left]]--;
            left++;
        }

        count += left;
        right++;
    }

    return count;
};