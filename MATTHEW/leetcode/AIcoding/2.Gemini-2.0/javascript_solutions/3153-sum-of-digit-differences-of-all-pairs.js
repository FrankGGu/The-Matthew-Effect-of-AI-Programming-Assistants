var sumDigitDifferences = function(nums) {
    let n = nums.length;
    let ans = 0;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            let a = nums[i].toString();
            let b = nums[j].toString();
            let minA = Infinity;
            let maxA = -Infinity;
            let minB = Infinity;
            let maxB = -Infinity;

            for(let k = 0; k < a.length; k++){
                minA = Math.min(minA, parseInt(a[k]));
                maxA = Math.max(maxA, parseInt(a[k]));
            }
            for(let k = 0; k < b.length; k++){
                minB = Math.min(minB, parseInt(b[k]));
                maxB = Math.max(maxB, parseInt(b[k]));
            }

            ans += Math.abs(maxA - minB) + Math.abs(maxB - minA);
        }
    }
    return ans;
};