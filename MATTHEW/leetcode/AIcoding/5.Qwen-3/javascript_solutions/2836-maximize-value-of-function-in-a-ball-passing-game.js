function findMaximumElegance(nums, k) {
    const n = nums.length;
    const m = Math.min(n, k);
    const pairs = [];

    for (let i = 0; i < m; ++i) {
        pairs.push([nums[i], i]);
    }

    pairs.sort((a, b) => a[0] - b[0]);

    let maxVal = 0;
    let sum = 0;
    const freq = new Map();
    const minHeap = [];

    for (let i = 0; i < m; ++i) {
        const [val, idx] = pairs[i];
        sum += val;
        if (freq.has(val)) {
            freq.set(val, freq.get(val) + 1);
            minHeap.push(val);
        } else {
            freq.set(val, 1);
        }
    }

    maxVal = sum;

    for (let i = m; i < n; ++i) {
        const [val, idx] = pairs[i];
        if (freq.has(val)) {
            continue;
        }

        if (minHeap.length === 0) {
            break;
        }

        const minVal = minHeap.shift();
        sum = sum - minVal + val;
        freq.set(minVal, freq.get(minVal) - 1);
        if (freq.get(minVal) === 0) {
            freq.delete(minVal);
        }
        freq.set(val, 1);

        maxVal = Math.max(maxVal, sum);
    }

    return maxVal;
}