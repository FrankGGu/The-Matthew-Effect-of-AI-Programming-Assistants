function maxCost(cost, labels, single) {
    let max = 0;
    let current = 0;
    let count = 0;

    for (let i = 0; i < cost.length; i++) {
        if (labels[i] === 'single') {
            current += cost[i];
            count++;
            if (count > single) {
                current -= cost[i - (count - 1)];
                count--;
            }
        } else {
            current += cost[i];
        }

        max = Math.max(max, current);
    }

    return max;
}