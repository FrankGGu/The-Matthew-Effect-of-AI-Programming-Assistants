function resultArray(nums, k, queries) {
    let n = nums.length;
    let res = [];
    for (let i = 0; i < k; i++) {
        let temp = [];
        for (let j = 0; j < n; j++) {
            temp.push(nums[j] * (i + 1));
        }
        nums = temp;
    }
    for (let q of queries) {
        res.push(nums[q]);
    }
    return res;
}