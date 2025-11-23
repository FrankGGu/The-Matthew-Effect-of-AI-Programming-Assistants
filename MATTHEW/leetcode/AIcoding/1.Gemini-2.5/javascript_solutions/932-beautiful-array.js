var beautifulArray = function(n) {
    const memo = new Map();

    function generate(N) {
        if (memo.has(N)) {
            return memo.get(N);
        }

        if (N === 1) {
            return [1];
        }

        const leftHalfSize = Math.ceil(N / 2);
        const rightHalfSize = Math.floor(N / 2);

        const leftBeautiful = generate(leftHalfSize);
        const rightBeautiful = generate(rightHalfSize);

        const oddElements = leftBeautiful.map(x => 2 * x - 1);
        const evenElements = rightBeautiful.map(x => 2 * x);

        const result = oddElements.concat(evenElements);
        memo.set(N, result);
        return result;
    }

    return generate(n);
};