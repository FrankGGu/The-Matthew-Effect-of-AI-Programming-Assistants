var maximumRequests = function(n, requests) {
    let maxCount = 0;

    const backtrack = (idx, count, balance) => {
        if (idx === requests.length) {
            if (balance.every(b => b === 0)) {
                maxCount = Math.max(maxCount, count);
            }
            return;
        }

        const [from, to] = requests[idx];
        balance[from]--;
        balance[to]++;
        backtrack(idx + 1, count + 1, balance);
        balance[from]++;
        balance[to]--;

        backtrack(idx + 1, count, balance);
    };

    backtrack(0, 0, Array(n).fill(0));
    return maxCount;
};