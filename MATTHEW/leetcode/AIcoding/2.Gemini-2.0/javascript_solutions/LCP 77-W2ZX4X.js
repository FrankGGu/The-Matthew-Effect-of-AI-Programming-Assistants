var runeReserve = function(runes, k) {
    runes.sort((a, b) => a - b);
    let maxLength = 0;
    let currentLength = 1;
    let start = 0;

    for (let i = 1; i < runes.length; i++) {
        if (runes[i] - runes[i - 1] === 1) {
            currentLength++;
        } else {
            while (runes[i] - runes[start] > k) {
                start++;
                currentLength--;
            }
            currentLength = i - start + 1;
        }
        maxLength = Math.max(maxLength, currentLength);
    }

    return maxLength;
};