var minOperations = function(nums1, nums2) {
    const n = nums1.length;
    let count1 = 0;
    let count2 = 0;

    const check = (a, b) => {
        let res = 0;
        let prev1 = nums1[n - 1];
        let prev2 = nums2[n - 1];
        for (let i = n - 2; i >= 0; i--) {
            let curr1 = nums1[i];
            let curr2 = nums2[i];

            if ((curr1 <= prev1 && curr2 <= prev2) || (curr1 <= prev2 && curr2 <= prev1)) {
                if (curr1 > prev1 || curr2 > prev2) {
                    if (curr1 <= prev2 && curr2 <= prev1) {
                        res++;
                        continue;
                    } else {
                        return Infinity;
                    }
                }
            } else if (curr1 <= prev1 && nums2[i] <= prev2) {
                //
            } else if (curr1 <= prev2 && nums2[i] <= prev1) {
                 res++;
            }
            else {
                return Infinity;
            }
        }

        return res;
    };

    let temp1 = [...nums1];
    let temp2 = [...nums2];

    let op1 = check(temp1,temp2);

    let swaptemp = nums1[n-1];
    nums1[n-1] = nums2[n-1];
    nums2[n-1] = swaptemp;

    let op2 = 1 + check(nums1, nums2);

    return Math.min(op1, op2);
};