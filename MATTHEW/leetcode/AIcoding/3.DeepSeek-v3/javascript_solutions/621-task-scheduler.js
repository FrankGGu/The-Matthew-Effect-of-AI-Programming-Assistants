var leastInterval = function(tasks, n) {
    const freq = new Array(26).fill(0);
    for (const task of tasks) {
        freq[task.charCodeAt(0) - 'A'.charCodeAt(0)]++;
    }
    freq.sort((a, b) => b - a);
    let maxFreq = freq[0] - 1;
    let idleSlots = maxFreq * n;
    for (let i = 1; i < 26; i++) {
        idleSlots -= Math.min(freq[i], maxFreq);
    }
    return idleSlots > 0 ? tasks.length + idleSlots : tasks.length;
};