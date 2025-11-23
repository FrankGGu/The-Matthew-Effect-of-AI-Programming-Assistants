var fullBloomFlowers = function(flowers, people) {
    const n = flowers.length;
    const startTimes = new Array(n);
    const endTimes = new Array(n);

    for (let i = 0; i < n; i++) {
        startTimes[i] = flowers[i][0];
        endTimes[i] = flowers[i][1];
    }

    startTimes.sort((a, b) => a - b);
    endTimes.sort((a, b) => a - b);

    const result = new Array(people.length);

    // Returns the index of the first element in arr that is >= target.
    // If all elements are < target, returns arr.length.
    function lowerBound(arr, target) {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    // Returns the index of the first element in arr that is > target.
    // If all elements are <= target, returns arr.length.
    function upperBound(arr, target) {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (arr[mid] <= target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    for (let i = 0; i < people.length; i++) {
        const p_time = people[i];

        // Count of flowers that have started blooming by or at p_time.
        // This is equivalent to finding the count of elements <= p_time in startTimes.
        const startedCount = upperBound(startTimes, p_time);

        // Count of flowers that have finished blooming strictly before p_time.
        // This is equivalent to finding the count of elements < p_time in endTimes.
        const endedCount = lowerBound(endTimes, p_time);

        result[i] = startedCount - endedCount;
    }

    return result;
};