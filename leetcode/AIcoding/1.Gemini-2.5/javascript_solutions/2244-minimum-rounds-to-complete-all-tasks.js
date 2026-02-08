var minimumRounds = function(tasks) {
    const freqMap = new Map();
    for (const task of tasks) {
        freqMap.set(task, (freqMap.get(task) || 0) + 1);
    }

    let totalRounds = 0;
    for (const count of freqMap.values()) {
        if (count === 1) {
            return -1;
        }
        totalRounds += Math.ceil(count / 3);
    }

    return totalRounds;
};