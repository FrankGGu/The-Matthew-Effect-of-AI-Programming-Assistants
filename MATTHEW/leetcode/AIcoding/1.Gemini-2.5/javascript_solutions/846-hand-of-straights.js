var isNStraightHand = function(hand, groupSize) {
    if (hand.length % groupSize !== 0) {
        return false;
    }

    if (groupSize === 1) {
        return true;
    }

    hand.sort((a, b) => a - b);

    const counts = new Map();
    for (const card of hand) {
        counts.set(card, (counts.get(card) || 0) + 1);
    }

    for (const card of hand) {
        if (counts.get(card) > 0) {
            for (let i = 0; i < groupSize; i++) {
                const currentCard = card + i;
                if (!counts.has(currentCard) || counts.get(currentCard) === 0) {
                    return false;
                }
                counts.set(currentCard, counts.get(currentCard) - 1);
            }
        }
    }

    return true;
};