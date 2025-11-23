function zeroArrayTransformationIV(nums, queries) {
    const n = nums.length;
    const result = [];
    const prefix = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    for (const [k, l, r] of queries) {
        let total = prefix[r + 1] - prefix[l];
        let count = r - l + 1;
        if (total % k !== 0) {
            result.push(false);
            continue;
        }
        let avg = total / k;
        let valid = true;
        for (let i = l; i <= r; i++) {
            if ((nums[i] + k) % k !== 0) {
                valid = false;
                break;
            }
        }
        result.push(valid);
    }

    return result;
}