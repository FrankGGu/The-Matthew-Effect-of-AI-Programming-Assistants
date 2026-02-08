var colorTheArray = function(n, queries) {
    const res = [];
    const nums = new Array(n).fill(0);
    let count = 0;

    for (const [index, color] of queries) {
        const left = index - 1;
        const right = index + 1;

        if (nums[index] !== 0) {
            if (left >= 0 && nums[left] === nums[index]) count--;
            if (right < n && nums[right] === nums[index]) count--;
        }

        nums[index] = color;

        if (left >= 0 && nums[left] === nums[index]) count++;
        if (right < n && nums[right] === nums[index]) count++;

        res.push(count);
    }

    return res;
};