function countAlmostEqualPairs(nums) {
    const n = nums.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let diff = 0;
            let a = nums[i];
            let b = nums[j];
            while (a > 0 || b > 0) {
                if ((a % 10) !== (b % 10)) {
                    diff++;
                }
                a = Math.floor(a / 10);
                b = Math.floor(b / 10);
            }
            if (diff <= 2) {
                count++;
            }
        }
    }

    return count;
}