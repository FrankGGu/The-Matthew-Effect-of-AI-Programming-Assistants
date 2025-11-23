var getGoodIndices = function(nums, mod) {
    const n = nums.length;
    const ans = [];
    const pow = (x, y, m) => {
        let res = 1;
        x %= m;
        while (y > 0) {
            if (y % 2 === 1) res = (res * x) % m;
            x = (x * x) % m;
            y = Math.floor(y / 2);
        }
        return res;
    };

    for (let i = 1; i < n - 1; i++) {
        let a = nums[i - 1];
        let b = nums[i];
        let c = nums[i + 1];
        if (pow(a, b, mod) === c) {
            ans.push(i);
        }
    }

    return ans;
};