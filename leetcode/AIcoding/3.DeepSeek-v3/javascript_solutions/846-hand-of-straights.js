var isNStraightHand = function(hand, groupSize) {
    if (hand.length % groupSize !== 0) return false;

    const count = new Map();
    for (const num of hand) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    const sorted = [...count.keys()].sort((a, b) => a - b);

    for (const num of sorted) {
        const cnt = count.get(num);
        if (cnt > 0) {
            for (let i = 1; i < groupSize; i++) {
                const next = num + i;
                if (!count.has(next) || count.get(next) < cnt) {
                    return false;
                }
                count.set(next, count.get(next) - cnt);
            }
        }
    }

    return true;
};