function bestHand(hand) {
    const count = {};
    for (const card of hand) {
        count[card] = (count[card] || 0) + 1;
    }
    const values = Object.values(count).sort((a, b) => b - a);
    if (values[0] >= 3) return "Three of a Kind";
    if (values[0] === 2) return "Pair";
    return "High Card";
}