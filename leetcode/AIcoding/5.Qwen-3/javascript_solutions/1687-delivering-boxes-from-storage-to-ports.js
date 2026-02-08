function boxDeliver(boxes, portsDistributed) {
    const n = boxes.length;
    const m = portsDistributed.length;
    const MOD = 1000000007;

    const dp = new Array(n + 1).fill(0);
    const pre = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        pre[i] = pre[i - 1] + boxes[i - 1];
    }

    for (let i = 1; i <= n; i++) {
        let minCost = Infinity;
        for (let j = Math.max(0, i - m); j < i; j++) {
            if (portsDistributed[j] !== portsDistributed[i - 1]) {
                minCost = Math.min(minCost, dp[j] + (pre[i] - pre[j]) % MOD);
            }
        }
        dp[i] = minCost % MOD;
    }

    return dp[n];
}