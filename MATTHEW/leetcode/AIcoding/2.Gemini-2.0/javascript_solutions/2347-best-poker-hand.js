var bestHand = function(ranks, suits) {
    const suitSet = new Set(suits);
    if (suitSet.size === 1) return "Flush";

    const rankCounts = {};
    for (const rank of ranks) {
        rankCounts[rank] = (rankCounts[rank] || 0) + 1;
    }

    let maxCount = 0;
    for (const rank in rankCounts) {
        maxCount = Math.max(maxCount, rankCounts[rank]);
    }

    if (maxCount >= 3) return "Three of a Kind";
    if (maxCount === 2) return "Pair";
    return "High Card";
};