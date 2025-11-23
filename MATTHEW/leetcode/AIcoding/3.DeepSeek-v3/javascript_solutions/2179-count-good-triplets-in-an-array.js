var goodTriplets = function(nums1, nums2) {
    const n = nums1.length;
    const pos = new Array(n);
    for (let i = 0; i < n; ++i) {
        pos[nums2[i]] = i;
    }

    const a = new Array(n);
    for (let i = 0; i < n; ++i) {
        a[i] = pos[nums1[i]];
    }

    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);

    const BITLeft = new Array(n + 1).fill(0);
    const BITRight = new Array(n + 1).fill(0);

    for (let i = 0; i < n; ++i) {
        let val = a[i] + 1;
        let sum = 0;
        for (let j = val - 1; j > 0; j -= j & -j) {
            sum += BITLeft[j];
        }
        left[i] = sum;
        for (let j = val; j <= n; j += j & -j) {
            BITLeft[j] += 1;
        }
    }

    for (let i = n - 1; i >= 0; --i) {
        let val = a[i] + 1;
        let sum = 0;
        for (let j = val - 1; j > 0; j -= j & -j) {
            sum += BITRight[j];
        }
        right[i] = sum;
        for (let j = val; j <= n; j += j & -j) {
            BITRight[j] += 1;
        }
    }

    let res = 0;
    for (let i = 0; i < n; ++i) {
        res += left[i] * (n - 1 - i - right[i]);
    }

    return res;
};