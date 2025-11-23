function numTriplets(nums1, nums2) {
    const count = (nums) => {
        const map = new Map();
        for (const num of nums) {
            map.set(num, (map.get(num) || 0) + 1);
        }
        let result = 0;
        for (const [num, freq] of map.entries()) {
            const square = num * num;
            for (const [other, otherFreq] of map.entries()) {
                if (other === num) {
                    result += freq * (freq - 1) / 2;
                } else {
                    result += freq * otherFreq;
                }
            }
        }
        return result;
    };
    return count(nums1) + count(nums2);
}