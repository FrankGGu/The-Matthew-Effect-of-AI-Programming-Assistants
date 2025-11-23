var maximizeSubarrays = function(nums) {
    let n = nums.length;
    let ans = 0;
    let currentOr = 0;
    for (let i = 0; i < n; i++) {
        currentOr |= nums[i];
        if (currentOr === 0) {
            ans++;
            currentOr = 0;
        }
    }
    if (currentOr > 0) {
        ans++;
    }
    let maxAns = ans;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let tempNums = [...nums];
            tempNums.splice(j, 1);
            tempNums.splice(i, 1);
            let tempAns = 0;
            let tempOr = 0;
            for (let k = 0; k < tempNums.length; k++) {
                tempOr |= tempNums[k];
                if (tempOr === 0) {
                    tempAns++;
                    tempOr = 0;
                }
            }
            if (tempOr > 0) {
                tempAns++;
            }
            maxAns = Math.max(maxAns, tempAns);
        }
    }
    return maxAns;
};