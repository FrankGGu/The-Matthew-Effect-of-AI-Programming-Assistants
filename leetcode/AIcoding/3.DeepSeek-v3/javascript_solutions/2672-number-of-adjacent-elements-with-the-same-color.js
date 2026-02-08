var colorTheArray = function(n, queries) {
    const nums = new Array(n).fill(0);
    const res = [];
    let count = 0;

    for (const [index, color] of queries) {
        const prevLeft = index > 0 ? nums[index - 1] : 0;
        const prevRight = index < n - 1 ? nums[index + 1] : 0;
        const current = nums[index];

        if (current !== 0) {
            if (current === prevLeft) count--;
            if (current === prevRight) count--;
        }

        nums[index] = color;

        if (color === prevLeft) count++;
        if (color === prevRight) count++;

        res.push(count);
    }

    return res;
};