var minimumRounds = function(tasks) {
    const freq = {};
    for (const task of tasks) {
        freq[task] = (freq[task] || 0) + 1;
    }

    let rounds = 0;
    for (const count of Object.values(freq)) {
        if (count === 1) {
            return -1;
        } else if (count % 3 === 0) {
            rounds += count / 3;
        } else if (count % 3 === 1) {
            rounds += (count - 4) / 3 + 2;
        } else {
            rounds += (count - 2) / 3 + 1;
        }
    }

    return rounds;
};