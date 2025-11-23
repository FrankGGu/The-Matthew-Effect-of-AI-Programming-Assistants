var handleQuery = function(nums1, nums2, queries) {
    const result = [];
    let sum = nums2.reduce((a, b) => a + b, 0);
    let bits = 0;
    for (let i = 0; i < nums1.length; i++) {
        if (nums1[i] === 1) {
            bits |= (1 << i);
        }
    }

    for (const query of queries) {
        if (query[0] === 1) {
            const l = query[1];
            const r = query[2];
            for (let i = l; i <= r; i++) {
                bits ^= (1 << i);
            }
        } else if (query[0] === 2) {
            const p = query[1];
            const count = bitCount(bits);
            sum += p * count;
        } else if (query[0] === 3) {
            result.push(sum);
        }
    }
    return result;
};

function bitCount(n) {
    n = n - ((n >> 1) & 0x55555555);
    n = (n & 0x33333333) + ((n >> 2) & 0x33333333);
    n = (n + (n >> 4)) & 0x0f0f0f0f;
    n = n + (n >> 8);
    n = n + (n >> 16);
    return n & 0x7f;
}