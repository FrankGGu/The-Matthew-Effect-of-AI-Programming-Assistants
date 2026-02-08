var minWastedSpace = function(packages, boxes) {
    const MOD = 1e9 + 7;
    packages.sort((a, b) => a - b);
    const n = packages.length;
    const prefix = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + packages[i];
    }

    let minWaste = Infinity;

    for (const supplierBoxes of boxes) {
        supplierBoxes.sort((a, b) => a - b);
        if (supplierBoxes[supplierBoxes.length - 1] < packages[n - 1]) {
            continue;
        }

        let total = 0;
        let prev = 0;

        for (const box of supplierBoxes) {
            if (box < packages[0]) continue;
            const idx = binarySearch(packages, box);
            const count = idx - prev;
            const sum = prefix[idx] - prefix[prev];
            total += box * count - sum;
            prev = idx;
            if (prev >= n) break;
        }

        if (prev >= n) {
            minWaste = Math.min(minWaste, total);
        }
    }

    return minWaste === Infinity ? -1 : minWaste % MOD;
};

function binarySearch(arr, target) {
    let left = 0;
    let right = arr.length;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] <= target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}