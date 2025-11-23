var minimumOperations = function(nums) {
    const n = nums.length;

    if (n <= 1) {
        return 0;
    }

    const mapEven = new Map();
    const mapOdd = new Map();

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            mapEven.set(nums[i], (mapEven.get(nums[i]) || 0) + 1);
        } else {
            mapOdd.set(nums[i], (mapOdd.get(nums[i]) || 0) + 1);
        }
    }

    let topEven = [{val: -1, freq: 0}, {val: -1, freq: 0}];
    for (const [val, freq] of mapEven) {
        if (freq > topEven[0].freq) {
            topEven[1] = topEven[0];
            topEven[0] = {val, freq};
        } else if (freq > topEven[1].freq) {
            topEven[1] = {val, freq};
        }
    }

    let topOdd = [{val: -1, freq: 0}, {val: -1, freq: 0}];
    for (const [val, freq] of mapOdd) {
        if (freq > topOdd[0].freq) {
            topOdd[1] = topOdd[0];
            topOdd[0] = {val, freq};
        } else if (freq > topOdd[1].freq) {
            topOdd[1] = {val, freq};
        }
    }

    const x1 = topEven[0].val;
    const freq_x1 = topEven[0].freq;
    const x2 = topEven[1].val;
    const freq_x2 = topEven[1].freq;

    const y1 = topOdd[0].val;
    const freq_y1 = topOdd[0].freq;
    const y2 = topOdd[1].val;
    const freq_y2 = topOdd[1].freq;

    const count_even = Math.ceil(n / 2);
    const count_odd = Math.floor(n / 2);

    let ans;

    if (x1 !== y1) {
        ans = (count_even - freq_x1) + (count_odd - freq_y1);
    } else {
        // x1 == y1, so we must pick one of x2 or y2
        // Option 1: Use x1 for even indices, and y2 for odd indices
        const ans1 = (count_even - freq_x1) + (count_odd - freq_y2);
        // Option 2: Use x2 for even indices, and y1 for odd indices
        const ans2 = (count_even - freq_x2) + (count_odd - freq_y1);
        ans = Math.min(ans1, ans2);
    }

    return ans;
};