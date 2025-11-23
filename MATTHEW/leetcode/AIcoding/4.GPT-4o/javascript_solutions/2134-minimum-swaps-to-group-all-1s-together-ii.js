var minSwaps = function(data) {
    const n = data.length;
    const totalOnes = data.reduce((acc, val) => acc + val, 0);
    if (totalOnes <= 1) return 0;

    let maxOnesInWindow = 0;
    let currentOnesInWindow = 0;

    for (let i = 0; i < totalOnes; i++) {
        currentOnesInWindow += data[i];
    }
    maxOnesInWindow = currentOnesInWindow;

    for (let i = totalOnes; i < n + totalOnes; i++) {
        currentOnesInWindow += data[i % n];
        currentOnesInWindow -= data[(i - totalOnes) % n];
        maxOnesInWindow = Math.max(maxOnesInWindow, currentOnesInWindow);
    }

    return totalOnes - maxOnesInWindow;
};