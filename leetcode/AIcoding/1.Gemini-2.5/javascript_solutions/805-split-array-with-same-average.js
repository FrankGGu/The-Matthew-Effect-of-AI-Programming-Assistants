var splitArraySameAverage = function(nums) {
    const n = nums.length;
    if (n === 1) {
        return false;
    }

    const totalSum = nums.reduce((acc, val) => acc + val, 0);

    function generateSubsets(arr) {
        const res = new Map();
        res.set(0, new Set([0])); // Base case: sum 0, count 0 (empty set)

        for (const num of arr) {
            const currentSums = Array.from(res.keys());
            for (const sum of currentSums) {
                const currentCounts = Array.from(res.get(sum));
                for (const count of currentCounts) {
                    const newSum = sum + num;
                    const newCount = count + 1;
                    if (!res.has(newSum)) {
                        res.set(newSum, new Set());
                    }
                    res.get(newSum).add(newCount);
                }
            }
        }
        return res;
    }

    const mid = Math.floor(n / 2);
    const nums1 = nums.slice(0, mid);
    const nums2 = nums.slice(mid);

    const map1 = generateSubsets(nums1);
    const map2 = generateSubsets(nums2);

    for (let k = 1; k < n; k++) {
        if ((k * totalSum) % n !== 0) {
            continue;
        }

        const targetSum = (k * totalSum) / n;

        for (const [s1, counts1] of map1.entries()) {
            for (const c1 of counts1) {
                const s2Needed = targetSum - s1;
                const c2Needed = k - c1;

                if (c2Needed >= 0 && c2Needed <= n - mid) {
                    if (map2.has(s2Needed)) {
                        if (map2.get(s2Needed).has(c2Needed)) {
                            return true;
                        }
                    }
                }
            }
        }
    }

    return false;
};