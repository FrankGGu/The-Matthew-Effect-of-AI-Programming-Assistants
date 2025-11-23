var minOperations = function(target, arr) {
    const targetMap = new Map();
    for (let i = 0; i < target.length; i++) {
        targetMap.set(target[i], i);
    }

    const indicesInTarget = [];
    for (const num of arr) {
        if (targetMap.has(num)) {
            indicesInTarget.push(targetMap.get(num));
        }
    }

    // Find the Longest Increasing Subsequence (LIS) of indicesInTarget
    // using patience sorting (N log N)
    const tails = []; // tails[i] is the smallest tail of all increasing subsequences of length i+1

    for (const num of indicesInTarget) {
        let low = 0;
        let high = tails.length - 1;
        let insertionPoint = tails.length; // Default to appending

        // Binary search to find the smallest element in tails that is >= num
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (tails[mid] < num) {
                low = mid + 1;
            } else {
                insertionPoint = mid; 
                high = mid - 1;
            }
        }

        if (insertionPoint === tails.length) {
            tails.push(num);
        } else {
            tails[insertionPoint] = num;
        }
    }

    const lisLength = tails.length;
    return target.length - lisLength;
};