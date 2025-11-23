var maximumRequests = function(n, requests) {
    let max = 0;
    const m = requests.length;

    for (let mask = 0; mask < (1 << m); mask++) {
        const degree = new Array(n).fill(0);
        let count = 0;

        for (let i = 0; i < m; i++) {
            if ((mask & (1 << i)) {
                const [from, to] = requests[i];
                degree[from]--;
                degree[to]++;
                count++;
            }
        }

        let valid = true;
        for (let i = 0; i < n; i++) {
            if (degree[i] !== 0) {
                valid = false;
                break;
            }
        }

        if (valid) {
            max = Math.max(max, count);
        }
    }

    return max;
};