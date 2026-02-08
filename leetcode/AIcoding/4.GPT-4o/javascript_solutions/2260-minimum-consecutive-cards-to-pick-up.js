var minimumCardPickup = function(cards) {
    const map = new Map();
    let minLength = Infinity;

    for (let i = 0; i < cards.length; i++) {
        if (map.has(cards[i])) {
            minLength = Math.min(minLength, i - map.get(cards[i]) + 1);
        }
        map.set(cards[i], i);
    }

    return minLength === Infinity ? -1 : minLength;
};