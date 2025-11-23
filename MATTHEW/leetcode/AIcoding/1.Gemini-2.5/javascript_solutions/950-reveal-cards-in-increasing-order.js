var revealCardsInIncreasingOrder = function(deck) {
    const n = deck.length;
    if (n === 0) {
        return [];
    }

    deck.sort((a, b) => a - b);

    const result = new Array(n);

    const queue = [];
    for (let i = 0; i < n; i++) {
        queue.push(i);
    }

    for (let i = 0; i < n; i++) {
        const position = queue.shift();
        result[position] = deck[i];

        if (queue.length > 0) {
            queue.push(queue.shift());
        }
    }

    return result;
};