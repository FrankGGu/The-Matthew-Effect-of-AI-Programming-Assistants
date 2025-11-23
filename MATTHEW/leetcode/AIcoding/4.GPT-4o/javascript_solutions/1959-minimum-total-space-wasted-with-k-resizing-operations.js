var minWastedSpace = function(A, packages) {
    A.sort((a, b) => a - b);
    const n = packages.length;
    const prefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + A[i];
    }

    let result = Infinity;
    for (const p of packages) {
        const sortedP = p.slice().sort((a, b) => a - b);
        let currWaste = 0;
        let j = 0;
        let valid = true;

        for (const capacity of sortedP) {
            let start = j;
            while (j < n && A[j] <= capacity) j++;
            if (start === j) {
                valid = false;
                break;
            }
            currWaste += (capacity * (j - start)) - (prefixSum[j] - prefixSum[start]);
        }

        if (valid) {
            result = Math.min(result, currWaste);
        }
    }

    return result === Infinity ? -1 : result;
};