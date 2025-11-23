function closestEqual(nums, queries) {
    const n = nums.length;
    const result = [];

    for (const [l, r] of queries) {
        let minDist = Infinity;
        let closestVal = -1;

        for (let i = l; i <= r; i++) {
            for (let j = l; j <= r; j++) {
                if (i !== j && nums[i] === nums[j]) {
                    const dist = Math.abs(i - j);
                    if (dist < minDist) {
                        minDist = dist;
                        closestVal = nums[i];
                    }
                }
            }
        }

        result.push(closestVal);
    }

    return result;
}