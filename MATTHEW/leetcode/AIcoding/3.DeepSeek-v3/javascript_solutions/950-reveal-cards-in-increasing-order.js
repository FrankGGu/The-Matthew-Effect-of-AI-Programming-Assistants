var deckRevealedIncreasing = function(deck) {
    deck.sort((a, b) => a - b);
    const result = [];
    while (deck.length) {
        if (result.length > 0) {
            result.unshift(result.pop());
        }
        result.unshift(deck.pop());
    }
    return result;
};