var kthGrammar = function(n, k) {
    if (n === 1) {
        return 0;
    }

    let length = Math.pow(2, n - 1);

    if (k <= length / 2) {
        return kthGrammar(n - 1, k);
    } else {
        return 1 - kthGrammar(n - 1, k - length / 2);
    }
};