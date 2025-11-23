var boxDelivering = function(boxes, portsCount, maxBoxes, maxWeight) {
    const n = boxes.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; ++i) {
        let weight = 0;
        let boxesCount = 0;
        let trips = 2;
        let lastPort = -1;

        for (let j = i; j >= 1 && boxesCount < maxBoxes && weight + boxes[j - 1][1] <= maxWeight; --j) {
            weight += boxes[j - 1][1];
            boxesCount++;
            const currentPort = boxes[j - 1][0];
            if (currentPort !== lastPort) {
                trips++;
                lastPort = currentPort;
            }
            dp[i] = Math.min(dp[i], dp[j - 1] + trips);
        }
    }

    return dp[n];
};