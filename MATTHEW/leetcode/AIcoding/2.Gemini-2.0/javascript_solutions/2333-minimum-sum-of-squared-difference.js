var minSumSquareDiff = function(nums1, nums2, k1, k2) {
    let n = nums1.length;
    let diff = [];
    for (let i = 0; i < n; i++) {
        diff.push(Math.abs(nums1[i] - nums2[i]));
    }

    diff.sort((a, b) => a - b);

    let totalK = k1 + k2;

    for (let i = n - 1; i >= 0; i--) {
        if (totalK === 0) break;
        let decrement = Math.min(totalK, diff[i] - (i > 0 ? diff[i - 1] : 0));

        if (decrement > 0) {
            for (let j = i; j >= 0; j--) {
                if (totalK > 0 && diff[j] > (i > 0 ? diff[i-1] : 0)) {
                    let d = Math.min(totalK, diff[j] - (i > 0 ? diff[i - 1] : 0));
                    diff[j] -= d;
                    totalK -= d;
                }
            }

        } else {
           for(let j = i; j >=0; j--){
                if(totalK > 0){
                    diff[j] = Math.max(0, diff[j] - 1);
                    totalK--;
                }
           }
        }
    }

    if(totalK > 0){
        for(let i = n-1; i >= 0; i--){
             if(totalK > 0){
                    diff[i] = Math.max(0, diff[i] - 1);
                    totalK--;
                }
        }
    }

    let sum = 0;
    for (let i = 0; i < n; i++) {
        sum += diff[i] * diff[i];
    }

    return sum;
};