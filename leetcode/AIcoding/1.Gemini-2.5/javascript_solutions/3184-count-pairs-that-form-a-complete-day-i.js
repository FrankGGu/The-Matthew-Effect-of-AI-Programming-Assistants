var countPairs = function(time) {
    let count = 0;
    const n = time.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if ((time[i] + time[j]) % 24 === 0) {
                count++;
            }
        }
    }

    return count;
};