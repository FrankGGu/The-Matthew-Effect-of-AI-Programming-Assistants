function isNStraightHand(hand, groupSize) {
    if (hand.length % groupSize !== 0) return false;

    const count = new Map();

    for (const card of hand) {
        count.set(card, (count.get(card) || 0) + 1);
    }

    const sortedKeys = Array.from(count.keys()).sort((a, b) => a - b);

    for (const key of sortedKeys) {
        if (count.get(key) > 0) {
            const currentCount = count.get(key);
            for (let i = 0; i < groupSize; i++) {
                const nextKey = key + i;
                if (!count.has(nextKey) || count.get(nextKey) < currentCount) {
                    return false;
                }
                count.set(nextKey, count.get(nextKey) - currentCount);
            }
        }
    }

    return true;
}