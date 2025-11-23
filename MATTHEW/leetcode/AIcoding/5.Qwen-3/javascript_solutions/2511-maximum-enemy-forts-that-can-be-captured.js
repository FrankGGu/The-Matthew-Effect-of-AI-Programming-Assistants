function captureForts(forts) {
    let max = 0;
    let i = 0;
    while (i < forts.length) {
        if (forts[i] === 1) {
            let j = i + 1;
            while (j < forts.length && forts[j] === 0) {
                j++;
            }
            if (j < forts.length && forts[j] === -1) {
                max = Math.max(max, j - i - 1);
            }
        }
        i++;
    }
    return max;
}