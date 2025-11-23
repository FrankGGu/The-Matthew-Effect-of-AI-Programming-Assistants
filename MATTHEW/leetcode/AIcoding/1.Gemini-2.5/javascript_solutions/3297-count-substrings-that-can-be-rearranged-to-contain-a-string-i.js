var countSubstrings = function(s) {
    let count = 0;
    let left = 0;
    let freq = new Array(3).fill(0); // freq[0] for 'a', freq[1] for 'b', freq[2] for 'c'

    for (let right = 0; right < s.length; right++) {
        freq[s.charCodeAt(right) - 'a'.charCodeAt(0)]++;

        while (freq[0] > 0 && freq[1] > 0 && freq[2] > 0) {
            // If the current window s[left...right] contains 'a', 'b', and 'c',
            // then any substring starting at 'left' and ending at 'right' or later
            // will also contain 'a', 'b', and 'c'.
            // The number of such substrings is (s.length - 1) - right + 1 = s.length - right.
            count += (s.length - right);

            // Shrink the window from the left by moving 'left' pointer
            freq[s.charCodeAt(left) - 'a'.charCodeAt(0)]--;
            left++;
        }
    }

    return count;
};