var bestHand = function(ranks, suits) {
    if (new Set(suits).size === 1) {
        return "Flush";
    }

    const rankCount = {};
    for (const rank of ranks) {
        rankCount[rank] = (rankCount[rank] || 0) + 1;
    }

    const counts = Object.values(rankCount);
    const maxCount = Math.max(...counts);

    if (maxCount >= 3) {
        return "Three of a Kind";
    } else if (maxCount === 2) {
        return "Pair";
    } else {
        return "High Card";
    }
};