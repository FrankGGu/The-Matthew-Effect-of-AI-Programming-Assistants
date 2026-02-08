var minimumOperations = function(nums) {
    const n = nums.length;
    if (n === 1) return 0;

    const evenCounts = {};
    const oddCounts = {};

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            evenCounts[nums[i]] = (evenCounts[nums[i]] || 0) + 1;
        } else {
            oddCounts[nums[i]] = (oddCounts[nums[i]] || 0) + 1;
        }
    }

    const evenSorted = Object.entries(evenCounts).sort(([, a], [, b]) => b - a);
    const oddSorted = Object.entries(oddCounts).sort(([, a], [, b]) => b - a);

    const evenMax = evenSorted[0] ? parseInt(evenSorted[0][0]) : null;
    const evenMaxCount = evenSorted[0] ? parseInt(evenSorted[0][1]) : 0;
    const evenSecondMax = evenSorted[1] ? parseInt(evenSorted[1][0]) : null;
    const evenSecondMaxCount = evenSorted[1] ? parseInt(evenSorted[1][1]) : 0;

    const oddMax = oddSorted[0] ? parseInt(oddSorted[0][0]) : null;
    const oddMaxCount = oddSorted[0] ? parseInt(oddSorted[0][1]) : 0;
    const oddSecondMax = oddSorted[1] ? parseInt(oddSorted[1][0]) : null;
    const oddSecondMaxCount = oddSorted[1] ? parseInt(oddSorted[1][1]) : 0;

    if (evenMax !== oddMax) {
        return n - evenMaxCount - oddMaxCount;
    } else {
        return n - Math.max(evenMaxCount + (oddSecondMaxCount || 0), oddMaxCount + (evenSecondMaxCount || 0));
    }
};