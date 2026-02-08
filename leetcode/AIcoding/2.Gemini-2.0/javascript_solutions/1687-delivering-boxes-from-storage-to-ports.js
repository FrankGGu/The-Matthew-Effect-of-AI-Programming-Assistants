var boxDelivering = function(boxes, portsCount, maxBoxes, maxWeight) {
    const n = boxes.length;
    const ports = new Array(n);
    const weights = new Array(n);
    const prefixWeight = new Array(n + 1).fill(0);
    const prefixPortChanges = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        ports[i] = boxes[i][0];
        weights[i] = boxes[i][1];
        prefixWeight[i + 1] = prefixWeight[i] + weights[i];
        if (i > 0) {
            prefixPortChanges[i + 1] = prefixPortChanges[i] + (ports[i] !== ports[i - 1] ? 1 : 0);
        } else {
            prefixPortChanges[1] = 0;
        }
    }

    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = i; j >= 1; j--) {
            if (i - j + 1 > maxBoxes || prefixWeight[i] - prefixWeight[j - 1] > maxWeight) {
                break;
            }

            let changes = prefixPortChanges[i] - prefixPortChanges[j];
            if (j > 1 && ports[j - 1] !== ports[j - 2]) {
                changes++;
            } else if (j === 1 && i > 0 && i < n){
                if (i < n && ports[i-1] !== ports[i]){
                    changes++;
                }
            }
            dp[i] = Math.min(dp[i], dp[j - 1] + changes + 1);
        }
    }

    return dp[n];
};