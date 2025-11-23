var deckRevealedIncreasing = function(deck) {
    deck.sort((a, b) => a - b);
    const result = [];
    const indexQueue = Array.from({ length: deck.length }, (_, i) => i);

    while (indexQueue.length > 0) {
        const firstIndex = indexQueue.shift();
        result[firstIndex] = deck.shift();

        if (indexQueue.length > 0) {
            const secondIndex = indexQueue.shift();
            indexQueue.push(secondIndex);
        }
    }

    return result;
};