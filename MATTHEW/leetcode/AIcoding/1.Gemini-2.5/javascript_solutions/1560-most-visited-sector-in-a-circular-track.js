var mostVisited = function(n, rounds) {
    const counts = new Array(n + 1).fill(0);

    for (let i = 0; i < rounds.length - 1; i++) {
        let start = rounds[i];
        let end = rounds[i+1];

        if (start <= end) {
            for (let j = start; j <= end; j++) {
                counts[j]++;
            }
        } else {
            for (let j = start; j <= n; j++) {
                counts[j]++;
            }
            for (let j = 1; j <= end; j++) {
                counts[j]++;
            }
        }
    }

    let maxCount = 0;
    for (let i = 1; i <= n; i++) {
        if (counts[i] > maxCount) {
            maxCount = counts[i];
        }
    }

    const result = [];
    for (let i = 1; i <= n; i++) {
        if (counts[i] === maxCount) {
            result.push(i);
        }
    }

    return result;
};