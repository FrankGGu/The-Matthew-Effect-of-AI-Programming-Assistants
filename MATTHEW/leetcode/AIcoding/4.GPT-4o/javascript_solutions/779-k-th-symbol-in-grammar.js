var kthGrammar = function(N, K) {
    if (N === 1) return 0;
    const parent = kthGrammar(N - 1, Math.ceil(K / 2));
    const isEven = K % 2 === 0;
    return parent === 0 ? (isEven ? 1 : 0) : (isEven ? 0 : 1);
};