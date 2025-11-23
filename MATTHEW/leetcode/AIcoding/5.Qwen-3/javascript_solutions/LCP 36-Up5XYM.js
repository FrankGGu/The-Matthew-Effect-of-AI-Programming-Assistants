function maxNumberOfGroups(nums) {
    nums.sort((a, b) => a - b);
    let count = {};
    for (let num of nums) {
        count[num] = (count[num] || 0) + 1;
    }
    let res = 0;
    let prev = 0;
    for (let key in count) {
        let freq = count[key];
        if (freq > prev) {
            res += prev;
            prev = freq;
        } else {
            res += freq;
        }
    }
    return res;
}