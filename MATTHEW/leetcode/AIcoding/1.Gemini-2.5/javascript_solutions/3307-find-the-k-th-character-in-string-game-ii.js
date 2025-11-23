var kthGrammar = function(n, k) {
    if (n === 1) {
        return 0;
    }

    const lengthOfPrevRow = Math.pow(2, n - 2);

    if (k <= lengthOfPrevRow) {
        return kthGrammar(n - 1, k);
    } else {
        const prevChar = kthGrammar(n - 1, k - lengthOfPrevRow);
        return prevChar === 0 ? 1 : 0;
    }
};