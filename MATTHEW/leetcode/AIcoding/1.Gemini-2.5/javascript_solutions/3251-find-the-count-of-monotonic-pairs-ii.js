class FenwickTree {
    constructor(size) {
        this.tree = new Array(size + 1).fill(0);
        this.size = size;
    }

    update(idx, delta) {
        idx++; // Convert to 1-based
        while (idx <= this.size) {
            this.tree[idx] += delta;
            idx += idx & (-idx); // Move to the next parent
        }
    }

    query(idx) {
        idx++; // Convert to 1-based
        let sum = 0;
        while (idx > 0) {
            sum += this.tree[idx];
            idx -= idx & (-idx); // Move to the parent
        }
        return sum;
    }
}

var findTheCountOfMonotonicPairsII = function(nums, k) {
    const n = nums.length;
    if (n < 2) {
        return 0;
    }

    const uniqueValues = new Set();
    for (const num of nums) {
        uniqueValues.add(num);
    }
    const sortedValues = Array.from(uniqueValues).sort((a, b) => a - b);

    const valueToRank = new Map();
    for (let i = 0; i < sortedValues.length; i++) {
        valueToRank.set(sortedValues[i], i);
    }

    const bit = new FenwickTree(sortedValues.length);
    let count = 0;

    const getUpperBoundIndex = (target) => {
        let low = 0;
        let high = sortedValues.length;
        let ans = sortedValues.length;

        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (sortedValues[mid] > target) {
                ans = mid;
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    };

    for (let j = 0; j < n; j++) {
        const targetVal = nums[j] + k;

        const upperBoundIndex = getUpperBoundIndex(targetVal);
        const maxRankToQuery = upperBoundIndex - 1;

        if (maxRankToQuery >= 0) {
            count += bit.query(maxRankToQuery);
        }

        const currentRank = valueToRank.get(nums[j]);
        bit.update(currentRank, 1);
    }

    return count;
};