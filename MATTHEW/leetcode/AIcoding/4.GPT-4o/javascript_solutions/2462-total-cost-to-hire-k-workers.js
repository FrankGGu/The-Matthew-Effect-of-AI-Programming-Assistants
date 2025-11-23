var totalCost = function(costs, k, candidates) {
    const n = costs.length;
    const minHeap = [];
    let left = 0;
    let right = n - 1;
    let total = 0;

    while (k > 0) {
        while (minHeap.length < candidates && left <= right) {
            minHeap.push(costs[left++]);
        }
        while (minHeap.length < candidates && right >= left) {
            minHeap.push(costs[right--]);
        }
        if (minHeap.length === 0) break;

        minHeap.sort((a, b) => a - b);
        total += minHeap.shift();
        k--;
    }

    return total;
};