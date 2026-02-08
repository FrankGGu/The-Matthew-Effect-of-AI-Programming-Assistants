var closestRoom = function(rooms, queries) {
    // Helper for binary search to find insertion point
    // Returns the index where 'val' should be inserted to maintain sorted order.
    // All elements at indices < returned_idx are < val.
    // All elements at indices >= returned_idx are >= val.
    const findInsertionPoint = (arr, val) => {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            const mid = Math.floor((low + high) / 2);
            if (arr[mid] < val) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    };

    // Helper to add a value to a sorted array, maintaining sorted order.
    // Note: This operation is O(N) due to splice, where N is the array length.
    // In worst-case, this leads to O(R^2) total for all additions, which might TLE for R=10^5.
    // A true O(logN) SortedList (e.g., balanced BST) is not native in JS.
    const addSorted = (arr, val) => {
        const idx = findInsertionPoint(arr, val);
        arr.splice(idx, 0, val);
    };

    // Helper to find the largest element in a sorted array that is less than or equal to 'val'.
    const findFloor = (arr, val) => {
        const idx = findInsertionPoint(arr, val);
        if (idx < arr.length && arr[idx] === val) {
            // 'val' itself is present in the array
            return val;
        }
        if (idx > 0) {
            // The element just before the insertion point is the floor
            return arr[idx - 1];
        }
        return undefined; // No floor found (all elements are greater than val)
    };

    // Helper to find the smallest element in a sorted array that is greater than or equal to 'val'.
    const findCeiling = (arr, val) => {
        const idx = findInsertionPoint(arr, val);
        if (idx < arr.length) {
            // The element at the insertion point is the ceiling
            return arr[idx];
        }
        return undefined; // No ceiling found (all elements are less than val)
    };

    // 1. Augment queries with their original indices to store results correctly
    const queriesWithIndex = queries.map((q, i) => [...q, i]);

    // 2. Sort rooms by size in descending order
    rooms.sort((a, b) => b[1] - a[1]);

    // 3. Sort queries by minSize in descending order
    queriesWithIndex.sort((a, b) => b[1] - a[1]);

    const results = new Array(queries.length).fill(-1);
    const roomIds = []; // This will be our dynamically maintained sorted list of room IDs
    let roomPtr = 0; // Pointer for iterating through sorted rooms

    // 4. Iterate through sorted queries
    for (const [preferredId, minSize, originalIdx] of queriesWithIndex) {
        // Add all rooms that satisfy the current query's minSize requirement
        // Since both rooms and queries are sorted by size/minSize descending,
        // we only add rooms with sufficient size as we process queries.
        while (roomPtr < rooms.length && rooms[roomPtr][1] >= minSize) {
            addSorted(roomIds, rooms[roomPtr][0]);
            roomPtr++;
        }

        // If no rooms satisfy the minSize requirement for this query, result is -1
        if (roomIds.length === 0) {
            results[originalIdx] = -1;
            continue;
        }

        let bestId = -1;
        let minDiff = Infinity;

        // Find the floor (largest ID <= preferredId)
        const floorId = findFloor(roomIds, preferredId);
        if (floorId !== undefined) {
            const diff = Math.abs(floorId - preferredId);
            minDiff = diff;
            bestId = floorId;
        }

        // Find the ceiling (smallest ID >= preferredId)
        const ceilingId = findCeiling(roomIds, preferredId);
        if (ceilingId !== undefined) {
            const diff = Math.abs(ceilingId - preferredId);
            if (diff < minDiff) {
                minDiff = diff;
                bestId = ceilingId;
            } else if (diff === minDiff) {
                // Tie-breaking rule: choose the smaller ID
                bestId = Math.min(bestId, ceilingId);
            }
        }

        results[originalIdx] = bestId;
    }

    return results;
};