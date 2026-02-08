var waysToPartition = function(nums, k) {
    let n = nums.length;
    let totalSum = 0;
    for (let num of nums) {
        totalSum += num;
    }

    let count = 0;
    let map = new Map();
    let leftSum = 0;

    for (let i = 0; i < n; i++) {
        let originalValue = nums[i];
        let diff = k - originalValue;
        let newTotalSum = totalSum + diff;

        if (newTotalSum % 2 === 0) {
            let target = newTotalSum / 2;
            let currentLeftSum = leftSum + diff;

            if (currentLeftSum === target) {
                count++;
            }
        }

        leftSum += originalValue;
    }

    let originalCount = 0;
    leftSum = 0;
    for(let i = 0; i < n - 1; i++){
        leftSum += nums[i];
        if(leftSum === totalSum - leftSum){
            originalCount++;
        }
    }

    if (k === totalSum / 2 && totalSum % 2 === 0) return Math.max(count, originalCount + 1);
    if(totalSum === 0 && k === 0) return n -1;

    if(totalSum % 2 === 0 && totalSum / 2 === k){
        return Math.max(count, originalCount + 1);
    }

    if(totalSum % 2 === 0 && totalSum / 2 === 0 && k === 0) return n-1;
    if(totalSum === 0 && k === 0) return n-1;

    leftSum = 0;
    let originalCount2 = 0;
    for(let i = 0; i < n - 1; i++){
        leftSum += nums[i];
        if(leftSum === totalSum - leftSum){
            originalCount2++;
        }
    }

    return Math.max(count, originalCount2);
};