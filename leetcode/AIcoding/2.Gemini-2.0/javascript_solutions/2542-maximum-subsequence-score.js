var maxScore = function(nums1, nums2, k) {
    const n = nums1.length;
    const pairs = [];
    for (let i = 0; i < n; i++) {
        pairs.push([nums1[i], nums2[i]]);
    }
    pairs.sort((a, b) => b[1] - a[1]);

    let minHeap = [];
    let sum = 0;
    let ans = 0;

    for (let i = 0; i < n; i++) {
        const [num1, num2] = pairs[i];

        minHeap.push(num1);
        minHeap.sort((a, b) => a - b);
        sum += num1;

        if (minHeap.length > k) {
            sum -= minHeap.shift();
        }

        if (minHeap.length === k) {
            ans = Math.max(ans, sum * num2);
        }
    }

    return ans;
};