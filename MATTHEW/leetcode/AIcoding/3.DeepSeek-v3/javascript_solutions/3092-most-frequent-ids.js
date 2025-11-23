var mostFrequentIDs = function(nums, freq) {
    const countMap = new Map();
    const maxHeap = new MaxPriorityQueue({ priority: (entry) => entry.count });
    const result = [];

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const change = freq[i];

        const currentCount = (countMap.get(num) || 0;
        const newCount = currentCount + change;

        if (newCount <= 0) {
            countMap.delete(num);
        } else {
            countMap.set(num, newCount);
        }

        maxHeap.enqueue({ id: num, count: newCount });

        while (!maxHeap.isEmpty()) {
            const top = maxHeap.front().element;
            if (countMap.get(top.id) === top.count) {
                result.push(top.count);
                break;
            } else {
                maxHeap.dequeue();
            }
        }

        if (maxHeap.isEmpty()) {
            result.push(0);
        }
    }

    return result;
};