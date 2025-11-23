var numTriplets = function(nums1, nums2) {
    let count = 0;

    const countPairs = (nums, squares) => {
        const map = new Map();
        for (const num of nums) {
            map.set(num, (map.get(num) || 0) + 1);
        }

        let res = 0;
        for (const [square, freq] of squares) {
            for (const [num, numFreq] of map) {
                if (square % num === 0) {
                    const other = square / num;
                    if (map.has(other)) {
                        if (num === other) {
                            res += numFreq * (numFreq - 1) / 2 * freq;
                        } else if (num < other) {
                            res += numFreq * (map.get(other) || 0) * freq;
                        }
                    }
                }
            }
        }
        return res;
    };

    const squares1 = new Map();
    for (const num of nums1) {
        const square = BigInt(num) * BigInt(num);
        squares1.set(square, (squares1.get(square) || 0) + 1);
    }

    const squares2 = new Map();
    for (const num of nums2) {
        const square = BigInt(num) * BigInt(num);
        squares2.set(square, (squares2.get(square) || 0) + 1);
    }

    count += countPairs(nums2, squares1);
    count += countPairs(nums1, squares2);

    return count;
};