var shortestSubsequence = function(arr, queries) {
    const n = arr.length;
    const m = queries.length;
    const ans = new Array(m).fill(0);

    for (let i = 0; i < m; i++) {
        const [target1, target2] = queries[i];
        let shortestLength = Infinity;
        let frequency = 0;

        for (let j = 0; j < n; j++) {
            if (arr[j] === target1) {
                for (let k = j + 1; k < n; k++) {
                    if (arr[k] === target2) {
                        const length = k - j + 1;
                        if (length < shortestLength) {
                            shortestLength = length;
                            frequency = 1;
                        } else if (length === shortestLength) {
                            frequency++;
                        }
                        break;
                    }
                }
            }
            if (arr[j] === target2) {
                for (let k = j + 1; k < n; k++) {
                    if (arr[k] === target1) {
                        const length = k - j + 1;
                        if (length < shortestLength) {
                            shortestLength = length;
                            frequency = 1;
                        } else if (length === shortestLength) {
                            frequency++;
                        }
                        break;
                    }
                }
            }
        }

        if (shortestLength === Infinity) {
            ans[i] = 0;
        } else {
            ans[i] = frequency;
        }
    }

    return ans;
};