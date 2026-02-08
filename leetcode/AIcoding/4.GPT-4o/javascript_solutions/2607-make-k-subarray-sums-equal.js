function makeKSubarraySumsEqual(arr, k) {
    const n = arr.length;
    const totalSum = arr.reduce((a, b) => a + b, 0);
    const target = totalSum / k;

    if (totalSum % k !== 0) return false;

    const sums = new Array(n).fill(0);
    sums[0] = arr[0];
    for (let i = 1; i < n; i++) {
        sums[i] = sums[i - 1] + arr[i];
    }

    const count = new Array(k).fill(0);
    const visited = new Array(n).fill(false);

    function canPartition(start, k) {
        if (k === 1) return true;
        let currSum = 0;

        for (let i = start; i < n; i++) {
            if (!visited[i]) {
                currSum += arr[i];
                visited[i] = true;

                if (currSum === target) {
                    if (canPartition(i + 1, k - 1)) return true;
                    currSum = 0;
                } else if (currSum > target) {
                    visited[i] = false;
                    currSum -= arr[i];
                }
            }
        }

        return false;
    }

    return canPartition(0, k);
}