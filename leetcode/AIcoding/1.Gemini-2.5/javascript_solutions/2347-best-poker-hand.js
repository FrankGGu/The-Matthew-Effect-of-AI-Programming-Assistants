var bestHand = function(ranks, suits) {
    const isFlush = new Set(suits).size === 1;

    if (isFlush) {
        return "Flush";
    }

    const rankCounts = {};
    for (const rank of ranks) {
        rankCounts[rank] = (rankCounts[rank] || 0) + 1;
    }

    let hasThreeOfAKind = false;
    let hasPair = false;

    for (const count of Object.values(rankCounts)) {
        if (count >= 3) {
            hasThreeOfAKind = true;
        } else if (count === 2) {
            hasPair = true;
        }
    }

    if (hasThreeOfAKind) {
        return "Three of a Kind";
    } else if (hasPair) {
        return "Pair";
    } else {
        return "High Card";
    }
};