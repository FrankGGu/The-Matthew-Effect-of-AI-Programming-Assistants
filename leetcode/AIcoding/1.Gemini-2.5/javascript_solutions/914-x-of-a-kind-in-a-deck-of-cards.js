var hasGroupsSizeX = function(deck) {
    if (deck.length < 2) {
        return false;
    }

    const freqMap = new Map();
    for (const card of deck) {
        freqMap.set(card, (freqMap.get(card) || 0) + 1);
    }

    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    let resultGcd = 0;
    for (const count of freqMap.values()) {
        if (resultGcd === 0) {
            resultGcd = count;
        } else {
            resultGcd = gcd(resultGcd, count);
        }
    }

    return resultGcd >= 2;
};