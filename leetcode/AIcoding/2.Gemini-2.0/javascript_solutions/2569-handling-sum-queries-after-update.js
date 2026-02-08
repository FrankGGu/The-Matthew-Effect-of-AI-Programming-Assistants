var handleQuery = function(nums1, nums2, queries) {
    let n = nums1.length;
    let m = nums2.length;
    let sum = nums2.reduce((a, b) => a + b, 0);
    let result = [];

    for (let query of queries) {
        let type = query[0];
        if (type === 1) {
            let l = query[1];
            let r = query[2];
            for (let i = l; i <= r; i++) {
                nums1[i] = 1 - nums1[i];
            }
        } else if (type === 2) {
            let p = query[1];
            let ones = 0;
            for (let i = 0; i < n; i++) {
                if (nums1[i] === 1) {
                    ones++;
                }
            }
            sum += ones * p;
        } else {
            result.push(sum);
        }
    }

    return result;
};