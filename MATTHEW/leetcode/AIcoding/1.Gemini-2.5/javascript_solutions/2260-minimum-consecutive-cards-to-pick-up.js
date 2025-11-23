var minimumCardPickup = function(cards) {
    let minLen = Infinity;
    const lastSeen = new Map();

    for (let i = 0; i < cards.length; i++) {
        const card = cards[i];
        if (lastSeen.has(card)) {
            const prevIndex = lastSeen.get(card);
            const currentLen = i - prevIndex + 1;
            minLen = Math.min(minLen, currentLen);
        }
        lastSeen.set(card, i);
    }

    return minLen === Infinity ? -1 : minLen;
};