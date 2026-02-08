var splitArraySameAverage = function(nums) {
    const n = nums.length;
    if (n === 1) return false;

    const sum = nums.reduce((acc, num) => acc + num, 0);

    for (let lenA = 1; lenA < n; lenA++) {
        if ((sum * lenA) % n === 0) {
            const targetSumA = (sum * lenA) / n;
            if (canSplit(nums, lenA, targetSumA)) return true;
        }
    }

    return false;

    function canSplit(nums, lenA, targetSumA) {
        const dp = new Set();
        dp.add(0);

        for (const num of nums) {
            const nextDp = new Set(dp);
            for (const sum of dp) {
                nextDp.add(sum + num);
            }
            dp.clear();
            for(const val of nextDp){
                dp.add(val);
            }
        }

        for (let i = 1; i <= lenA; i++) {
            if (dp.has(targetSumA) ) {
                let count = 0;
                let tempSum = 0;

                function backtrack(index, currentCount, currentSum){
                    if(currentCount === lenA && currentSum === targetSumA){
                        return true;
                    }
                    if(currentCount > lenA || index >= nums.length){
                        return false;
                    }

                    if(backtrack(index + 1, currentCount + 1, currentSum + nums[index])){
                        return true;
                    }
                    if(backtrack(index + 1, currentCount, currentSum)){
                        return true;
                    }
                    return false;
                }

                if(backtrack(0, 0, 0)){
                    return true;
                }
            }
        }
        return false;
    }
};