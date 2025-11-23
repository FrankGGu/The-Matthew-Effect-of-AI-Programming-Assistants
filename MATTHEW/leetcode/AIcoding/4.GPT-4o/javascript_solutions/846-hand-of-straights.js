var isNStraightHand = function(hand, W) {
    if (hand.length % W !== 0) return false;
    const count = {};
    hand.forEach(card => count[card] = (count[card] || 0) + 1);
    const uniqueCards = Object.keys(count).map(Number).sort((a, b) => a - b);

    for (let i = 0; i < uniqueCards.length; i++) {
        const card = uniqueCards[i];
        if (count[card] > 0) {
            const numOfHands = count[card];
            for (let j = 0; j < W; j++) {
                if (!count[card + j] || count[card + j] < numOfHands) {
                    return false;
                }
                count[card + j] -= numOfHands;
            }
        }
    }
    return true;
};