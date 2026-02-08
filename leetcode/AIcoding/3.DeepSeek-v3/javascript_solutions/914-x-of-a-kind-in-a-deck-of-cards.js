var hasGroupsSizeX = function(deck) {
    const count = {};
    for (const card of deck) {
        count[card] = (count[card] || 0) + 1;
    }
    const values = Object.values(count);
    let g = values[0];
    for (const val of values) {
        g = gcd(g, val);
        if (g < 2) return false;
    }
    return g >= 2;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}