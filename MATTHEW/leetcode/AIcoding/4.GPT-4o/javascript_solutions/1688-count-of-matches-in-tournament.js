var numberOfMatches = function(n) {
    let matches = 0;
    while (n > 1) {
        const currentMatches = Math.floor(n / 2);
        matches += currentMatches;
        n = Math.ceil(n / 2);
    }
    return matches;
};