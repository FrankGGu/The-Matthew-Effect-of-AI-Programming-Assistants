var nextGreaterElement = function(nums) {
    const n = nums.length;
    const ans = new Array(n).fill(-1);

    // s1 stores indices for finding the first NGE.
    // s1 maintains indices such that nums[index] is strictly increasing.
    const s1 = []; 

    // s2 stores indices that have found their first NGE and are now looking for their second NGE.
    // s2 also maintains indices such that nums[index] is strictly increasing.
    const s2 = []; 

    for (let i = 0; i < n; i++) {
        const currentVal = nums[i];

        // Process s2: elements in s2 are looking for their second NGE.
        // If currentVal is greater than nums[s2.top()], then currentVal is the second NGE.
        while (s2.length > 0 && nums[s2[s2.length - 1]] < currentVal) {
            ans[s2.pop()] = currentVal;
        }

        // Process s1: elements in s1 are looking for their first NGE.
        // If currentVal is greater than nums[s1.top()], then currentVal is the first NGE.
        // These elements then move to a temporary list.
        const tempPoppedFromS1 = [];
        while (s1.length > 0 && nums[s1[s1.length - 1]] < currentVal) {
            tempPoppedFromS1.push(s1.pop());
        }

        // Push current index to s1.
        s1.push(i);

        // Elements that just found their first NGE (currentVal) now need to find their second NGE.
        // Push them to s2.
        // To maintain s2's monotonicity (nums[s2.top()] increasing),
        // elements from tempPoppedFromS1 must be pushed in increasing order of their values.
        // `tempPoppedFromS1` contains indices in decreasing order of their values (because they were popped from `s1` which was increasing).
        // So, iterate `tempPoppedFromS1` in reverse to push them to `s2` in increasing value order.
        for (let k = tempPoppedFromS1.length - 1; k >= 0; k--) {
            s2.push(tempPoppedFromS1[k]);
        }
    }

    return ans;
};