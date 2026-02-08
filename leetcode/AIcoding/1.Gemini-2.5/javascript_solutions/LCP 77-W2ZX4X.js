var runeReserve = function(runes) {
    if (runes.length === 0) {
        return 0;
    }

    runes.sort((a, b) => a - b);

    let maxCount = 0;
    let left = 0;

    for (let right = 0; right < runes.length; right++) {
        while (runes[right] - runes[left] > 1) {
            left++;
        }
        maxCount = Math.max(maxCount, right - left + 1);
    }

    return maxCount;
};