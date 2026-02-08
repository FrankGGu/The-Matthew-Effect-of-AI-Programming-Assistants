var deckRevealedIncreasing = function(deck) {
    deck.sort((a, b) => a - b);
    const n = deck.length;
    const result = new Array(n);
    const indexQueue = [];

    for (let i = 0; i < n; i++) {
        indexQueue.push(i);
    }

    for (let card of deck) {
        result[indexQueue.shift()] = card;
        if (indexQueue.length > 0) {
            indexQueue.push(indexQueue.shift());
        }
    }

    return result;
};