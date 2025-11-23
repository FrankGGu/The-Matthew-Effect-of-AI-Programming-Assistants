var numberOfPairs = function(nums1, nums2, k) {
    const freq = new Map();
    for (const num of nums2) {
        const key = num * k;
        freq.set(key, (freq.get(key) || 0) + 1);
    }

    let count = 0;
    for (const num of nums1) {
        for (let i = 1; i <= Math.sqrt(num); i++) {
            if (num % i === 0) {
                const j = num / i;
                if (freq.has(i)) {
                    count += freq.get(i);
                }
                if (i !== j && freq.has(j)) {
                    count += freq.get(j);
                }
            }
        }
    }
    return count;
};