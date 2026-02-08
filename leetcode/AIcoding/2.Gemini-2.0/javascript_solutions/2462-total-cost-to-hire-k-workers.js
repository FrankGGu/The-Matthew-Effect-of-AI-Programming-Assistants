var totalCost = function(costs, k, candidates) {
    let n = costs.length;
    let left = 0;
    let right = n - 1;
    let pq1 = [];
    let pq2 = [];
    let cost = 0;

    const insert = (pq, val) => {
        pq.push(val);
        pq.sort((a, b) => a - b);
    }

    const extractMin = (pq) => {
        if (pq.length === 0) return Infinity;
        return pq.shift();
    }

    for (let i = 0; i < candidates && left <= right; i++) {
        insert(pq1, costs[left++]);
    }

    for (let i = 0; i < candidates && left <= right; i++) {
        insert(pq2, costs[right--]);
    }

    for (let i = 0; i < k; i++) {
        let cost1 = extractMin(pq1);
        let cost2 = extractMin(pq2);

        if (cost1 <= cost2) {
            cost += cost1;
            if (left <= right) {
                insert(pq1, costs[left++]);
            }
        } else {
            cost += cost2;
            if (left <= right) {
                insert(pq2, costs[right--]);
            }
        }
    }

    return cost;
};