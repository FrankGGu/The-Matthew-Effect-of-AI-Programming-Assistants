var makeSimilar = function(nums1, nums2) {
    const odd1 = [];
    const even1 = [];
    const odd2 = [];
    const even2 = [];

    for (const num of nums1) {
        if (num % 2 === 0) {
            even1.push(num);
        } else {
            odd1.push(num);
        }
    }

    for (const num of nums2) {
        if (num % 2 === 0) {
            even2.push(num);
        } else {
            odd2.push(num);
        }
    }

    odd1.sort((a, b) => a - b);
    even1.sort((a, b) => a - b);
    odd2.sort((a, b) => a - b);
    even2.sort((a, b) => a - b);

    let ops = 0;
    for (let i = 0; i < odd1.length; i++) {
        ops += Math.abs(odd1[i] - odd2[i]);
    }

    for (let i = 0; i < even1.length; i++) {
        ops += Math.abs(even1[i] - even2[i]);
    }

    return ops / 4;
};