var hasGroupsSizeX = function(deck) {
    if (deck.length < 2) {
        return false;
    }

    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    const counts = new Map();
    for (const card of deck) {
        counts.set(card, (counts.get(card) || 0) + 1);
    }

    const frequencies = Array.from(counts.values());

    if (frequencies.length === 0) {
        return false;
    }

    let resultGcd = frequencies[0];
    for (let i = 1; i < frequencies.length; i++) {
        resultGcd = gcd(resultGcd, frequencies[i]);
    }

    return resultGcd >= 2;
};