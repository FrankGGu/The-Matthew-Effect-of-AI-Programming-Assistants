var minCost = function(basket1, basket2) {
    const freq1 = new Map();
    const freq2 = new Map();
    const totalFreq = new Map();
    let minFruitVal = Infinity;

    for (const fruit of basket1) {
        freq1.set(fruit, (freq1.get(fruit) || 0) + 1);
        totalFreq.set(fruit, (totalFreq.get(fruit) || 0) + 1);
        minFruitVal = Math.min(minFruitVal, fruit);
    }

    for (const fruit of basket2) {
        freq2.set(fruit, (freq2.get(fruit) || 0) + 1);
        totalFreq.set(fruit, (totalFreq.get(fruit) || 0) + 1);
        minFruitVal = Math.min(minFruitVal, fruit);
    }

    const misplacedFromB1 = []; // Fruits that are in basket1 but should be in basket2
    const misplacedFromB2 = []; // Fruits that are in basket2 but should be in basket1

    for (const [fruit, count] of totalFreq.entries()) {
        if (count % 2 !== 0) {
            return -1; // Impossible to make counts even
        }
        const targetCount = count / 2;
        const b1Has = freq1.get(fruit) || 0;
        const b2Has = freq2.get(fruit) || 0;

        if (b1Has > targetCount) {
            for (let i = 0; i < b1Has - targetCount; i++) {
                misplacedFromB1.push(fruit);
            }
        } else if (b2Has > targetCount) {
            for (let i = 0; i < b2Has - targetCount; i++) {
                misplacedFromB2.push(fruit);
            }
        }
    }

    misplacedFromB1.sort((a, b) => a - b);
    misplacedFromB2.sort((a, b) => a - b);

    let totalCost = 0;
    // The number of fruits to move out of basket1 (misplacedFromB1.length)
    // must equal the number to move out of basket2 (misplacedFromB2.length).
    // This is guaranteed because basket1 and basket2 have equal initial lengths
    // and the total count of each fruit type is even.

    // We need to perform `k = misplacedFromB1.length` swaps.
    // For each pair of fruits (one from misplacedFromB1, one from misplacedFromB2),
    // we have two options to resolve them:
    // 1. Direct swap: Swap `A` from `basket1` with `B` from `basket2`. Cost `min(A, B)`.
    // 2. Two-step swap using the global minimum fruit value `minFruitVal`:
    //    Swap `A` (from `basket1`) with `minFruitVal` (from `basket2`). Cost `minFruitVal`.
    //    Then swap `minFruitVal` (now in `basket1`) with `B` (from `basket2`). Cost `minFruitVal`.
    //    Total cost for this two-step process: `2 * minFruitVal`.
    // To minimize the total cost, for each pair, we choose the cheaper option.
    // To minimize the direct swap costs, we pair the smallest available misplaced fruit from `basket1`
    // with the smallest available misplaced fruit from `basket2`.
    for (let i = 0; i < misplacedFromB1.length; i++) {
        totalCost += Math.min(misplacedFromB1[i], misplacedFromB2[i], 2 * minFruitVal);
    }

    return totalCost;
};