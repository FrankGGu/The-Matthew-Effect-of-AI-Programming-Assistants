var findBestValue = function(arr, target) {
    arr.sort((a, b) => a - b);
    let n = arr.length;
    let prefixSum = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        prefixSum[i] = prefixSum[i - 1] + arr[i - 1];
    }

    let left = 0;
    let right = arr[n - 1];
    let bestValue = 0;
    let minDiff = Infinity;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let index = binarySearch(arr, mid);
        let sum = prefixSum[index] + (n - index) * mid;
        let diff = Math.abs(sum - target);

        if (diff < minDiff) {
            minDiff = diff;
            bestValue = mid;
        } else if (diff === minDiff && mid < bestValue) {
            bestValue = mid;
        }

        if (sum > target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return bestValue;

    function binarySearch(arr, target) {
        let left = 0;
        let right = arr.length - 1;
        while (left <= right) {
            let mid = Math.floor((left + right) / 2);
            if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }
};