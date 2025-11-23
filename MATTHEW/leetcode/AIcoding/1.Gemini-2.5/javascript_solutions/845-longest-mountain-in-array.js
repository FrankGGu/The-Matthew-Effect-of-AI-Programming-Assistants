var longestMountain = function(arr) {
    const n = arr.length;
    if (n < 3) {
        return 0;
    }

    let maxLen = 0;
    let i = 0;

    while (i < n) {
        let j = i;
        // Skip flat or decreasing parts to find a potential start of an increasing sequence
        // 'j' will be the first element of a potential increasing sequence (or the current 'i' if no flat/decreasing part)
        while (j + 1 < n && arr[j] >= arr[j+1]) {
            j++;
        }

        let up = j;
        // Find the peak (end of increasing sequence)
        while (up + 1 < n && arr[up] < arr[up+1]) {
            up++;
        }

        let peak = up;
        // Find the end of the decreasing sequence
        while (peak + 1 < n && arr[peak] > arr[peak+1]) {
            peak++;
        }

        let down = peak;

        // A valid mountain requires:
        // 1. An increasing part (j < up)
        // 2. A decreasing part (up < down)
        if (j < up && up < down) {
            maxLen = Math.max(maxLen, down - j + 1);
        }

        // Move 'i' to the end of the current examined segment.
        // If a mountain was found, 'down' is its end.
        // If no mountain was found (e.g., only increasing or only decreasing/flat),
        // 'down' will be 'j' or 'up', effectively advancing 'i' past the non-mountain segment.
        // This ensures we don't re-evaluate elements that were part of the current segment.
        i = down;
    }

    return maxLen;
};