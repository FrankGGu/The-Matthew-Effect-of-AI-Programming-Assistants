var minOperations = function(nums1, nums2) {
    const sum1 = nums1.reduce((a, b) => a + b, 0);
    const sum2 = nums2.reduce((a, b) => a + b, 0);
    if (sum1 === sum2) return 0;

    let larger = sum1 > sum2 ? nums1 : nums2;
    let smaller = sum1 > sum2 ? nums2 : nums1;
    let diff = Math.abs(sum1 - sum2);

    const changes = [];
    for (const num of larger) {
        changes.push(num - 1);
    }
    for (const num of smaller) {
        changes.push(6 - num);
    }

    changes.sort((a, b) => b - a);

    let operations = 0;
    for (const change of changes) {
        if (diff <= 0) break;
        diff -= change;
        operations++;
    }

    return diff <= 0 ? operations : -1;
};