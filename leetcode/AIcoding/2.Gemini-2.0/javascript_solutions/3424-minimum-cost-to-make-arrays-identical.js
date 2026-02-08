var minCost = function(nums1, nums2, changeCost) {
    const n = nums1.length;
    const s1 = new Set(nums1);
    const s2 = new Set(nums2);
    const common = new Set();
    for (const num of s1) {
        if (s2.has(num)) {
            common.add(num);
        }
    }

    if (common.size === 0) {
        let canMakeSame = true;
        for (let i = 0; i < n; i++) {
            if (nums1[i] !== nums2[i]) {
                canMakeSame = false;
                break;
            }
        }
        if (!canMakeSame) return -1;
        else return 0;
    }

    const allValues = new Set([...nums1, ...nums2]);
    const values = Array.from(allValues);
    values.sort((a, b) => a - b);

    let dp1 = new Array(values.length).fill(Infinity);
    let dp2 = new Array(values.length).fill(Infinity);

    for (let i = 0; i < values.length; i++) {
        if (nums1[0] === values[i]) {
            dp1[i] = 0;
        }
        if (nums2[0] === values[i]) {
            dp2[i] = 0;
        }
    }

    for (let i = 1; i < n; i++) {
        let newDp1 = new Array(values.length).fill(Infinity);
        let newDp2 = new Array(values.length).fill(Infinity);

        let min1 = Infinity;
        let min2 = Infinity;

        for (let j = 0; j < values.length; j++) {
            min1 = Math.min(min1, dp1[j]);
            min2 = Math.min(min2, dp2[j]);

            if (nums1[i] === values[j]) {
                newDp1[j] = Math.min(newDp1[j], dp1[j]);
                newDp1[j] = Math.min(newDp1[j], dp2[j] + changeCost);
            } else {
                newDp1[j] = Math.min(newDp1[j], dp1[j] + changeCost);
                newDp1[j] = Math.min(newDp1[j], dp2[j] + changeCost);
            }

            if (nums2[i] === values[j]) {
                newDp2[j] = Math.min(newDp2[j], dp2[j]);
                newDp2[j] = Math.min(newDp2[j], dp1[j] + changeCost);
            } else {
                newDp2[j] = Math.min(newDp2[j], dp2[j] + changeCost);
                newDp2[j] = Math.min(newDp2[j], dp1[j] + changeCost);
            }

        }

        dp1 = newDp1;
        dp2 = newDp2;
    }

    let ans = Infinity;
    for (let i = 0; i < values.length; i++) {
        ans = Math.min(ans, dp1[i]);
        ans = Math.min(ans, dp2[i]);
    }

    return ans;
};