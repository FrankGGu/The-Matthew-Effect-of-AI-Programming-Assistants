var circularArrayLoop = function(nums) {
    const n = nums.length;

    const getNext = (arr, currentIdx, isForward, n) => {
        const val = arr[currentIdx];
        const newIsForward = val > 0;

        // Check for direction mismatch
        if (newIsForward !== isForward) {
            return -1;
        }

        let nextIdx = (currentIdx + val) % n;

        // Handle negative results from modulo operator
        if (nextIdx < 0) {
            nextIdx += n;
        }

        // Check for a self-loop of length 1
        if (nextIdx === currentIdx) {
            return -1;
        }

        return nextIdx;
    };

    for (let i = 0; i < n; i++) {
        // If nums[i] is 0, it means this node has been visited and
        // either doesn't lead to a valid cycle or was part of a path that didn't form a cycle.
        if (nums[i] === 0) {
            continue;
        }

        let slow = i;
        let fast = i;
        const isForward = nums[i] > 0;

        while (true) {
            slow = getNext(nums, slow, isForward, n);
            if (slow === -1) break;

            fast = getNext(nums, fast, isForward, n);
            if (fast === -1) break;

            fast = getNext(nums, fast, isForward, n);
            if (fast === -1) break;

            if (slow === fast) {
                return true; // Found a cycle of length > 1
            }
        }

        // If no cycle found from this starting point `i`, mark all nodes in this path as 0.
        // This prevents re-processing them and ensures termination.
        let curr = i;
        while (nums[curr] !== 0 && (nums[curr] > 0 === isForward)) {
            const next = getNext(nums, curr, isForward, n);
            nums[curr] = 0; // Mark as visited
            if (next === -1) break; // Invalid next step or direction mismatch or length 1 cycle
            curr = next;
        }
    }

    return false; // No valid cycle found in the entire array
};