var hasGroupsSizeX = function(deck) {
    const count = {};
    for (const card of deck) {
        count[card] = (count[card] || 0) + 1;
    }

    const values = Object.values(count);
    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);

    let x = values[0];
    for (let i = 1; i < values.length; i++) {
        x = gcd(x, values[i]);
    }

    return x >= 2;
};