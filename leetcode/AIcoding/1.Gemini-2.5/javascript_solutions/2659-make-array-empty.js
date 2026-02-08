class FenwickTree {
    constructor(size) {
        this.tree = new Array(size + 1).fill(0);
        this.size = size;
    }

    // Add value to index (1-based)
    update(index, value) {
        index++; // Convert to 1-based
        while (index <= this.size) {
            this.tree[index] += value;
            index += index & (-index);
        }
    }

    // Get sum up to index (1-based)
    query(index) {
        index++; // Convert to 1-based
        let sum = 0;
        while (index > 0) {
            sum += this.tree[index];
            index -= index & (-index);
        }
        return sum;
    }

    // Get value at specific index (0-based)
    get(index) {
        return this.query(index) - this.query(index - 1);
    }

    // Find the k-th smallest active index (0-based)
    // This requires a binary search on the Fenwick tree
    findKth(k) {
        let low = 0;
        let high = this.size - 1;
        let ans = -1;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (this.query(mid) >= k) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
}

var makeArrayEmpty = function(nums) {
    const n = nums.length;
    const valIdxPairs = [];
    for (let i = 0; i < n; i++) {
        valIdxPairs.push([nums[i], i]);
    }

    // Sort by value, then by original index for tie-breaking
    valIdxPairs.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    const ft = new FenwickTree(n);
    for (let i = 0; i < n; i++) {
        ft.update(i, 1); // Mark all elements as present
    }

    let operations = 0;
    let currentValIdxPtr = 0; // Pointer to the sorted valIdxPairs

    while (ft.query(n - 1) > 0) { // While there are still elements in the array
        operations++;

        // Find the smallest element(s) currently in the array
        // currentValIdxPtr points to the first element in valIdxPairs that is still present
        while (currentValIdxPtr < n && ft.get(valIdxPairs[currentValIdxPtr][1]) === 0) {
            currentValIdxPtr++;
        }

        const smallestValue = valIdxPairs[currentValIdxPtr][0];
        let maxOriginalIndexForSmallestValue = valIdxPairs[currentValIdxPtr][1];

        // Find the largest original index among all occurrences of the smallest value that are still present
        let tempPtr = currentValIdxPtr + 1;
        while (tempPtr < n && valIdxPairs[tempPtr][0] === smallestValue) {
            if (ft.get(valIdxPairs[tempPtr][1]) === 1) { // If this duplicate is still present
                maxOriginalIndexForSmallestValue = Math.max(maxOriginalIndexForSmallestValue, valIdxPairs[tempPtr][1]);
            }
            tempPtr++;
        }

        // Determine how many elements to remove in this operation
        // This is the count of active elements up to maxOriginalIndexForSmallestValue (inclusive)
        const countToRemove = ft.query(maxOriginalIndexForSmallestValue);

        // Remove these `countToRemove` elements
        let removedCountInThisOp = 0;
        let currentK = 1; // Represents the k-th active element
        while (removedCountInThisOp < countToRemove) {
            // Find the original index of the currentK-th active element
            const originalIndexToRemove = ft.findKth(currentK);
            ft.update(originalIndexToRemove, -1); // Mark as removed
            removedCountInThisOp++;
            currentK++;
        }
    }

    return operations;
};