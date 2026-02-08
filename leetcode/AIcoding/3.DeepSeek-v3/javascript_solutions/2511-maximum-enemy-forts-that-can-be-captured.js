var captureForts = function(forts) {
    let maxForts = 0;
    let n = forts.length;

    for (let i = 0; i < n; i++) {
        if (forts[i] === 1) {
            let left = i - 1;
            let right = i + 1;
            let countLeft = 0;
            let countRight = 0;

            while (left >= 0 && forts[left] === 0) {
                left--;
                countLeft++;
            }
            if (left >= 0 && forts[left] === -1) {
                maxForts = Math.max(maxForts, countLeft);
            }

            while (right < n && forts[right] === 0) {
                right++;
                countRight++;
            }
            if (right < n && forts[right] === -1) {
                maxForts = Math.max(maxForts, countRight);
            }
        }
    }

    return maxForts;
};