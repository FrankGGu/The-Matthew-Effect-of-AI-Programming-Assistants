var minCost = function(cost, s) {
    const n = cost.length;
    let zeroCost = [];
    let oneCost = [];

    for (let i = 0; i < n; i++) {
        if (s[i] === '0') {
            zeroCost.push(cost[i]);
        } else {
            oneCost.push(cost[i]);
        }
    }

    zeroCost.sort((a, b) => a - b);
    oneCost.sort((a, b) => a - b);

    let ans = 0;
    let i = 0, j = 0;
    while (i < zeroCost.length || j < oneCost.length) {
        if (i < zeroCost.length && (j === oneCost.length || zeroCost[i] <= oneCost[j])) {
            ans += zeroCost[i];
            i++;
        } else {
            ans += oneCost[j];
            j++;
        }
    }

    let ans2 = 0;
    i = 0, j = 0;
    let zeroCost2 = [...zeroCost];
    let oneCost2 = [...oneCost];

    zeroCost2.sort((a, b) => a - b);
    oneCost2.sort((a, b) => a - b);

    i = 0;
    j = 0;
    while (i < zeroCost2.length || j < oneCost2.length) {
        if (j < oneCost2.length && (i === zeroCost2.length || oneCost2[j] <= zeroCost2[i])) {
            ans2 += oneCost2[j];
            j++;
        } else {
            ans2 += zeroCost2[i];
            i++;
        }
    }

    let initialCost = 0;
    for (let i = 0; i < n; i++) {
        initialCost += cost[i];
    }

    let currentCost = 0;
    let zeroIndex = 0;
    let oneIndex = 0;
    for (let i = 0; i < n; i++) {
        if (s[i] === '0') {
            currentCost += zeroCost[zeroIndex];
            zeroIndex++;
        } else {
            currentCost += oneCost[oneIndex];
            oneIndex++;
        }
    }

    let currentCost2 = 0;
    zeroIndex = 0;
    oneIndex = 0;
    for (let i = 0; i < n; i++) {
        if (s[i] === '0') {
            currentCost2 += zeroCost2[zeroIndex];
            zeroIndex++;
        } else {
            currentCost2 += oneCost2[oneIndex];
            oneIndex++;
        }
    }

    return Math.min(currentCost, currentCost2);
};