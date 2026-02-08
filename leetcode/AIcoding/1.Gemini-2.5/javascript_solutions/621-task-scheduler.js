var leastInterval = function(tasks, n) {
    const freq = new Array(26).fill(0);
    for (const task of tasks) {
        freq[task.charCodeAt(0) - 'A'.charCodeAt(0)]++;
    }

    freq.sort((a, b) => b - a);

    const maxFreq = freq[0];
    let maxFreqCount = 0;
    for (let i = 0; i < freq.length; i++) {
        if (freq[i] === maxFreq) {
            maxFreqCount++;
        } else {
            break;
        }
    }

    const timeFromFormula = (maxFreq - 1) * (n + 1) + maxFreqCount;

    return Math.max(tasks.length, timeFromFormula);
};