var hasGroupsSizeX = function(deck) {
    if (deck.length < 2) return false;
    const counts = {};
    for (const card of deck) {
        counts[card] = (counts[card] || 0) + 1;
    }

    const gcd = (a, b) => {
        if (b === 0) return a;
        return gcd(b, a % b);
    }

    let result = 0;
    for (const count of Object.values(counts)) {
        result = gcd(result, count);
    }

    return result >= 2;
};