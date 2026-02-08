var minCostToCollectChocolates = function(cost, x) {
    const n = cost.length;

    const bigCost = cost.map(c => BigInt(c));
    const bigX = BigInt(x);

    const final_slot_costs = new Array(n).fill(0n);

    const B = new Array(n);
    for (let i = 0; i < n; i++) {
        B[i] = bigCost[i] - BigInt(i) * bigX;
    }

    const P = new Array(n);
    P[0] = B[0];
    for (let j = 1; j < n; j++) {
        P[j] = P[j - 1] < B[j] ? P[j - 1] : B[j];
    }

    const S = new Array(n);
    S[n - 1] = B[n - 1];
    for (let j = n - 2; j >= 0; j--) {
        S[j] = S[j + 1] < B[j] ? S[j + 1] : B[j];
    }

    const bigN = BigInt(n);
    const INF = BigInt(10) ** BigInt(20);

    for (let j = 0; j < n; j++) {
        const term1 = P[j];
        let term2;
        if (j + 1 < n) {
            term2 = S[j + 1] + bigN * bigX;
        } else {
            term2 = INF;
        }
        final_slot_costs[j] = BigInt(j) * bigX + (term1 < term2 ? term1 : term2);
    }

    let total_min_cost = 0n;
    for (let j = 0; j < n; j++) {
        total_min_cost += final_slot_costs[j];
    }

    return total_min_cost;
};