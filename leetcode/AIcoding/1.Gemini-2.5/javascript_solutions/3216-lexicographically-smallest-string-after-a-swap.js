var lexicographicallySmallestStringAfterASwap = function(s) {
    let minStr = s;
    let n = s.length;
    let sArr = s.split('');

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            // Swap characters at indices i and j
            [sArr[i], sArr[j]] = [sArr[j], sArr[i]];

            // Form the new string
            let currentStr = sArr.join('');

            // Compare with the current minimum string
            if (currentStr < minStr) {
                minStr = currentStr;
            }

            // Swap back to restore the original order for the next iteration
            [sArr[i], sArr[j]] = [sArr[j], sArr[i]];
        }
    }

    return minStr;
};