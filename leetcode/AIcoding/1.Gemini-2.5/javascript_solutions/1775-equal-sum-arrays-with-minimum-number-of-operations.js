var minOperations = function(nums1, nums2) {
    let sum1 = 0;
    for (let num of nums1) {
        sum1 += num;
    }

    let sum2 = 0;
    for (let num of nums2) {
        sum2 += num;
    }

    if (nums1.length * 6 < nums2.length || nums2.length * 6 < nums1.length) {
        return -1;
    }

    if (sum1 === sum2) {
        return 0;
    }

    let diff = Math.abs(sum1 - sum2);
    let ops = 0;

    let counts = new Array(6).fill(0);

    if (sum1 > sum2) {
        for (let num of nums1) {
            counts[num - 1]++;
        }
        for (let num of nums2) {
            counts[6 - num]++;
        }
    } else {
        for (let num of nums2) {
            counts[num - 1]++;
        }
        for (let num of nums1) {
            counts[6 - num]++;
        }
    }

    for (let i = 5; i >= 1; i--) {
        if (diff <= 0) {
            break;
        }

        let gain = i;
        let numItemsWithThisGain = counts[i];

        if (numItemsWithThisGain > 0) {
            let neededItems = Math.ceil(diff / gain);
            let itemsToTake = Math.min(numItemsWithThisGain, neededItems);

            diff -= itemsToTake * gain;
            ops += itemsToTake;
        }
    }

    return ops;
};