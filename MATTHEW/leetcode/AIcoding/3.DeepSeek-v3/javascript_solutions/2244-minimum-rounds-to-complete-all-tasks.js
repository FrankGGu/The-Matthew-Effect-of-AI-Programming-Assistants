var minimumRounds = function(tasks) {
    const freq = {};
    for (const task of tasks) {
        freq[task] = (freq[task] || 0) + 1;
    }

    let rounds = 0;
    for (const count of Object.values(freq)) {
        if (count === 1) {
            return -1;
        }
        rounds += Math.ceil(count / 3);
    }
    return rounds;
};