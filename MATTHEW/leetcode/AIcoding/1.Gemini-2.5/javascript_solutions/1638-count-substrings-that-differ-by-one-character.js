var countSubstrings = function(s, t) {
    let m = s.length;
    let n = t.length;
    let totalCount = 0;

    // Iterate through all possible starting positions for the single differing character in s (index i)
    for (let i = 0; i < m; i++) {
        // Iterate through all possible starting positions for the single differing character in t (index j)
        for (let j = 0; j < n; j++) {
            // If characters at current positions differ,
            // they could be the single differing character in a pair of substrings.
            if (s[i] !== t[j]) {
                let leftMatch = 0;
                // Count matching characters to the left of the current differing pair (s[i], t[j])
                // k represents the offset from i (or j)
                // s[i-1] vs t[j-1], s[i-2] vs t[j-2], etc.
                for (let k = 1; i - k >= 0 && j - k >= 0; k++) {
                    if (s[i - k] === t[j - k]) {
                        leftMatch++;
                    } else {
                        // Stop if a mismatch is found, as we need consecutive matches
                        break;
                    }
                }

                let rightMatch = 0;
                // Count matching characters to the right of the current differing pair (s[i], t[j])
                // s[i+1] vs t[j+1], s[i+2] vs t[j+2], etc.
                for (let k = 1; i + k < m && j + k < n; k++) {
                    if (s[i + k] === t[j + k]) {
                        rightMatch++;
                    } else {
                        // Stop if a mismatch is found, as we need consecutive matches
                        break;
                    }
                }

                // If s[i] and t[j] are the differing characters,
                // then any substring formed by extending 'x' characters to the left (0 to leftMatch)
                // and 'y' characters to the right (0 to rightMatch) will also differ by exactly one character.
                // The number of ways to choose 'x' is (leftMatch + 1).
                // The number of ways to choose 'y' is (rightMatch + 1).
                // The total number of such substring pairs is the product.
                totalCount += (leftMatch + 1) * (rightMatch + 1);
            }
        }
    }

    return totalCount;
};