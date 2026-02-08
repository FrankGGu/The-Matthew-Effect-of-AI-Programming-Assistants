var boxDelivering = function(boxes, portsCount, maxBoxes, maxWeight) {
    const n = boxes.length;
    let dp = new Array(n + 1).fill(0);
    let weight = 0, boxesCount = 0, start = 0, deliveries = 0;

    for (let i = 1; i <= n; i++) {
        weight += boxes[i - 1][1];
        boxesCount++;
        while (weight > maxWeight || boxesCount > maxBoxes) {
            weight -= boxes[start][1];
            boxesCount--;
            start++;
        }
        dp[i] = dp[start] + 1;
        if (boxes[i - 1][0] !== boxes[start][0]) deliveries++;
        dp[i] = Math.min(dp[i], deliveries + 1);
    }

    return dp[n];
};