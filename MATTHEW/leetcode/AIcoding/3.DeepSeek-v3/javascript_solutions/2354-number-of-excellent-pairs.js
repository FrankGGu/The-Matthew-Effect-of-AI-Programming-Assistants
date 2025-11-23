var countExcellentPairs = function(nums, k) {
    const uniqueNums = [...new Set(nums)];
    const countBits = (num) => {
        let count = 0;
        while (num > 0) {
            count += num & 1;
            num = num >> 1;
        }
        return count;
    };

    const bitCounts = uniqueNums.map(num => countBits(num));
    bitCounts.sort((a, b) => a - b);

    let res = 0;
    const n = bitCounts.length;

    for (let i = 0; i < n; i++) {
        const target = k - bitCounts[i];
        let left = 0, right = n;
        while (left < right) {
            const mid = Math.floor((left + right) / 2);
            if (bitCounts[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        res += n - left;
    }

    return res;
};