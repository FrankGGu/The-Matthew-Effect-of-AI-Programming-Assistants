var minWastedSpace = function(packages, boxes) {
    const MOD = 10**9 + 7;
    packages.sort((a, b) => a - b);
    let n = packages.length;
    let prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + packages[i];
    }

    let minWaste = Infinity;
    for (let boxSizes of boxes) {
        boxSizes.sort((a, b) => a - b);
        if (boxSizes[boxSizes.length - 1] < packages[n - 1]) {
            continue;
        }
        let waste = 0;
        let start = 0;
        for (let boxSize of boxSizes) {
            let end = binarySearch(packages, boxSize);
            if (end > start) {
                waste += (BigInt(end - start) * BigInt(boxSize) - BigInt(prefixSum[end] - prefixSum[start]));
                start = end;
            }
        }
        minWaste = Math.min(minWaste, Number(waste % BigInt(MOD)));
    }

    if (minWaste === Infinity) {
        return -1;
    }
    return minWaste;

    function binarySearch(arr, target) {
        let left = 0;
        let right = arr.length;
        while (left < right) {
            let mid = Math.floor((left + right) / 2);
            if (arr[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};