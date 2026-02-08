var maximumSwap = function(num) {
    const s = String(num).split('');
    const n = s.length;

    for (let i = 0; i < n; i++) {
        let rightmostMaxDigit = -1;
        let rightmostMaxIdx = -1;

        // Find the largest digit to the right of s[i], and its rightmost index.
        // Iterate from right to left to ensure we get the rightmost index for the largest digit.
        for (let j = n - 1; j > i; j--) {
            if (s[j] > rightmostMaxDigit) {
                rightmostMaxDigit = s[j];
                rightmostMaxIdx = j;
            }
            // If s[j] is equal to rightmostMaxDigit, we don't update rightmostMaxIdx
            // because j is to the left of the current rightmostMaxIdx (due to right-to-left iteration).
            // This ensures rightmostMaxIdx always points to the rightmost occurrence of the largest digit found so far.
        }

        // If a digit larger than s[i] was found to its right
        if (rightmostMaxIdx !== -1 && s[rightmostMaxIdx] > s[i]) {
            // Perform the swap
            [s[i], s[rightmostMaxIdx]] = [s[rightmostMaxIdx], s[i]];
            return parseInt(s.join(''));
        }
    }

    // If no beneficial swap was found after checking all positions,
    // the original number is already the maximum.
    return num;
};