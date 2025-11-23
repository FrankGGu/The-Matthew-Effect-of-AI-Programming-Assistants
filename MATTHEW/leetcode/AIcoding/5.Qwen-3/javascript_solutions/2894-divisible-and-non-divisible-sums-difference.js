function differenceOfSums(n, m) {
    let sumDivisible = 0;
    let sumNonDivisible = 0;
    for (let i = 1; i <= n; i++) {
        if (i % m === 0) {
            sumDivisible += i;
        } else {
            sumNonDivisible += i;
        }
    }
    return sumNonDivisible - sumDivisible;
}