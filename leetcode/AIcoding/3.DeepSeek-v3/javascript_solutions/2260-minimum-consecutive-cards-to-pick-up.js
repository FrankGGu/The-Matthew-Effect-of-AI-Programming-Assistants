var minimumCardPickup = function(cards) {
    const map = new Map();
    let min = Infinity;

    for (let i = 0; i < cards.length; i++) {
        const card = cards[i];
        if (map.has(card)) {
            min = Math.min(min, i - map.get(card) + 1);
        }
        map.set(card, i);
    }

    return min === Infinity ? -1 : min;
};