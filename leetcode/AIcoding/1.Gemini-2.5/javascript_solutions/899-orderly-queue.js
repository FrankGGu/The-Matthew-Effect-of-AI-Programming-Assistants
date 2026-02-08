var orderlyQueue = function(s, k) {
    if (k === 1) {
        let minS = s;
        const n = s.length;
        for (let i = 0; i < n; i++) {
            // Move s[0] to position i
            // s.substring(1, i) gives characters from index 1 up to (but not including) i
            // s[0] is the character being moved
            // s.substring(i) gives characters from index i to the end
            // Example: s = "abc", i = 1
            // s.substring(1, 1) = ""
            // s[0] = 'a'
            // s.substring(1) = "bc"
            // tempS = "" + 'a' + "bc" = "abc" (This is if we move s[0] to position 0, which is equivalent to i=0 in the loop, or in this specific example, it's not quite right.
            // Let's re-evaluate the string construction for k=1.
            // s = "s0s1s2...sn-1"
            // To move s0 to position j: s1s2...sj s0 sj+1...sn-1
            // This means: s.substring(1, j) + s[0] + s.substring(j)
            // Example: s = "cba", n=3
            // i=0: s.substring(1, 0) + s[0] + s.substring(0) -> "" + 'c' + "cba" -> "ccba" -- This is wrong.
            // The problem states: "take the leftmost character and move it to any position in the string."
            // Let original string be `s`.
            // The leftmost character is `s[0]`.
            // The rest of the string is `s.substring(1)`.
            // If we insert `s[0]` at position `j` (0-indexed) in `s.substring(1)`:
            // `s.substring(1).slice(0, j) + s[0] + s.substring(1).slice(j)`
            // This is equivalent to: `s.substring(1, j + 1) + s[0] + s.substring(j + 1)`
            // No, this is also incorrect.
            // Let's take `s = "cba"`.
            // Leftmost character is 'c'. Remaining string is "ba".
            // Possible positions for 'c' in "ba" (length 2) are 0, 1, 2.
            // Position 0: 'c' + "ba" = "cba"
            // Position 1: "b" + 'c' + "a" = "bca"
            // Position 2: "ba" + 'c' = "bac"
            // The minimum of these is "bac".
            //
            // The loop should generate these strings.
            // For i from 0 to n-1 (representing the new index of the original s[0]):
            // `tempS = s.substring(1, i) + s[0] + s.substring(i)` is the correct form for inserting s[0] at index i.
            // Let's re-trace `s = "cba"`, n=3.
            // `s[0] = 'c'`.
            // `i = 0`: `s.substring(1, 0)` is `""`. `s.substring(0)` is `cba`.
            // `tempS = "" + 'c' + "cba"` -> `c c b a` -- This is wrong.
            // The logic should be:
            // `s_prime = s.substring(1)`
            // `tempS = s_prime.substring(0, i) + s[0] + s_prime.substring(i)`
            // Example: `s = "cba"`, `s_prime = "ba"`
            // `i = 0`: `"" + 'c' + "ba"` = "cba"
            // `i = 1`: `"b" + 'c' + "a"` = "bca"
            // `i = 2`: `"ba" + 'c' + ""` = "bac"
            // This is correct.
            let s_prime = s.substring(1);
            let tempS = s_prime.substring(0, i) + s[0] + s_prime.substring(i);
            if (tempS < minS) {
                minS = tempS;
            }
        }
        return minS;
    } else {
        // If k >= 2, we can achieve any permutation of the string.
        // Therefore, the lexicographically smallest string is the sorted version of the original string.
        return s.split('').sort().join('');
    }
};