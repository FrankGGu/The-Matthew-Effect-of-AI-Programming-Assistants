var minAbsoluteSumDiff = function(nums1, nums2) {
    const MOD = 1e9 + 7;
    const n = nums1.length;
    let totalDiff = 0;
    let maxImprove = 0;
    const sortedNums1 = [...nums1].sort((a, b) => a - b);

    for (let i = 0; i < n; i++) {
        const diff = Math.abs(nums1[i] - nums2[i]);
        totalDiff = (totalDiff + diff) % MOD;

        const pos = binarySearch(sortedNums1, nums2[i]);
        const newDiff = Math.abs(sortedNums1[pos] - nums2[i]);
        const improve = diff - newDiff;
        maxImprove = Math.max(maxImprove, improve);
    }

    return (totalDiff - maxImprove + MOD) % MOD;
};

function binarySearch(arr, target) {
    let left = 0, right = arr.length - 1;
    while (left < right) {
        const mid = Math.floor((left + right) / 2);
        if (arr[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left < arr.length && arr[left] === target ? left : Math.max(left - 1, 0);
}