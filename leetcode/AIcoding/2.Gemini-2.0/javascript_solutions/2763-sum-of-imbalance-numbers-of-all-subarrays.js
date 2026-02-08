var sumImbalanceNumbers = function(nums) {
    let n = nums.length;
    let totalImbalance = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            let subarray = nums.slice(i, j + 1);
            if (subarray.length <= 1) continue;

            let sortedSubarray = [...subarray].sort((a, b) => a - b);
            let imbalance = 0;
            for (let k = 1; k < sortedSubarray.length; k++) {
                if (sortedSubarray[k] - sortedSubarray[k - 1] > 1) {
                    imbalance++;
                }
            }
            totalImbalance += imbalance;
        }
    }

    return totalImbalance;
};