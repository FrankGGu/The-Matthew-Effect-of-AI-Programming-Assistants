function rangeSum(nums, n, left, right, mod) {
    const minHeap = [];
    for (let i = 0; i < n; i++) {
        minHeap.push([nums[i], i, i]);
    }
    minHeap.sort((a, b) => a[0] - b[0]);

    let result = 0;
    let count = 0;

    while (count < right) {
        const [sum, start, end] = minHeap.shift();
        count++;
        if (count >= left) {
            result = (result + sum) % mod;
        }
        if (end + 1 < n) {
            const newSum = sum + nums[end + 1];
            minHeap.push([newSum, start, end + 1]);
            minHeap.sort((a, b) => a[0] - b[0]);
        }
    }

    return result;
}