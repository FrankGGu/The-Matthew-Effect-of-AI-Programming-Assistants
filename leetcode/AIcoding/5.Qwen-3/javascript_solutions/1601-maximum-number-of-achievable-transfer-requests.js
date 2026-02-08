function maximumTransferRequests(n, requests) {
    const m = requests.length;
    let max = 0;

    for (let mask = 1; mask < (1 << m); mask++) {
        const inDegree = new Array(n).fill(0);
        const outDegree = new Array(n).fill(0);
        let count = 0;

        for (let i = 0; i < m; i++) {
            if ((mask >> i) & 1) {
                const [from, to] = requests[i];
                outDegree[from]++;
                inDegree[to]++;
                count++;
            }
        }

        let valid = true;
        for (let i = 0; i < n; i++) {
            if (inDegree[i] !== outDegree[i]) {
                valid = false;
                break;
            }
        }

        if (valid) {
            max = Math.max(max, count);
        }
    }

    return max;
}