var bestHand = function(ranks) {
    const count = Array(14).fill(0);
    for (let rank of ranks) {
        count[rank]++;
    }

    let maxCount = Math.max(...count);

    if (maxCount >= 3) return "Three of a Kind";
    if (maxCount === 2) return "Pair";
    return "High Card";
};