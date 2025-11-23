function smallestRange(nums) {
    const minHeap = new MinPriorityQueue();
    let max = -Infinity;
    for (let i = 0; i < nums.length; i++) {
        minHeap.enqueue({ value: nums[i][0], listIndex: i, elementIndex: 0 });
        max = Math.max(max, nums[i][0]);
    }

    let range = [0, Infinity];

    while (minHeap.size() === nums.length) {
        const { value, listIndex, elementIndex } = minHeap.dequeue().element;

        if (range[1] - range[0] > max - value) {
            range = [value, max];
        }

        if (elementIndex + 1 < nums[listIndex].length) {
            const nextValue = nums[listIndex][elementIndex + 1];
            minHeap.enqueue({ value: nextValue, listIndex, elementIndex: elementIndex + 1 });
            max = Math.max(max, nextValue);
        }
    }

    return range;
}