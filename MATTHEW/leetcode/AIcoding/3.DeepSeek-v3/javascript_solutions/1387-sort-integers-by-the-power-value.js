var getKth = function(lo, hi, k) {
    const powerCache = new Map();

    function getPower(x) {
        if (x === 1) return 0;
        if (powerCache.has(x)) return powerCache.get(x);

        let steps;
        if (x % 2 === 0) {
            steps = 1 + getPower(x / 2);
        } else {
            steps = 1 + getPower(3 * x + 1);
        }

        powerCache.set(x, steps);
        return steps;
    }

    const nums = [];
    for (let i = lo; i <= hi; i++) {
        nums.push(i);
    }

    nums.sort((a, b) => {
        const powerA = getPower(a);
        const powerB = getPower(b);
        if (powerA !== powerB) {
            return powerA - powerB;
        } else {
            return a - b;
        }
    });

    return nums[k - 1];
};