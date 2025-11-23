var minimumOperations = function(A) {
    const count = {};
    for (let i = 0; i < A.length; i++) {
        if (!count[A[i]]) count[A[i]] = { even: 0, odd: 0 };
        if (i % 2 === 0) count[A[i]].even++;
        else count[A[i]].odd++;
    }

    const freq = Object.values(count);
    const evenArr = freq.map(x => x.even);
    const oddArr = freq.map(x => x.odd);

    const [firstMaxEven, secondMaxEven] = evenArr
        .map((v, i) => [v, i])
        .sort((a, b) => b[0] - a[0])
        .slice(0, 2)
        .map(x => x[1]);

    const [firstMaxOdd, secondMaxOdd] = oddArr
        .map((v, i) => [v, i])
        .sort((a, b) => b[0] - a[0])
        .slice(0, 2)
        .map(x => x[1]);

    if (firstMaxEven !== firstMaxOdd) {
        return A.length - (evenArr[firstMaxEven] + oddArr[firstMaxOdd]);
    }

    return Math.min(
        A.length - (evenArr[firstMaxEven] + oddArr[secondMaxOdd]),
        A.length - (evenArr[secondMaxEven] + oddArr[firstMaxOdd])
    );
};