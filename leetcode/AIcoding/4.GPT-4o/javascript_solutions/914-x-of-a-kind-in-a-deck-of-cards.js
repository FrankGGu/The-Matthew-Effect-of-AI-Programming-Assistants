var hasGroupsSizeX = function(deck) {
    const count = {};
    for (const card of deck) {
        count[card] = (count[card] || 0) + 1;
    }

    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    let result = 0;

    for (const key in count) {
        result = gcd(result, count[key]);
    }

    return result >= 2;
};