var isNStraightHand = function(hand, groupSize) {
    if (hand.length % groupSize !== 0) {
        return false;
    }

    hand.sort((a, b) => a - b);
    const map = new Map();

    for (const num of hand) {
        map.set(num, (map.get(num) || 0) + 1);
    }

    for (const num of hand) {
        if (map.get(num) > 0) {
            map.set(num, map.get(num) - 1);
            for (let i = 1; i < groupSize; i++) {
                const nextNum = num + i;
                if (!map.has(nextNum) || map.get(nextNum) <= 0) {
                    return false;
                }
                map.set(nextNum, map.get(nextNum) - 1);
            }
        }
    }

    return true;
};