var numWays = function(s) {
    const n = s.length;
    let ones = 0;
    for (let i = 0; i < n; i++) {
        if (s[i] === '1') {
            ones++;
        }
    }

    if (ones % 3 !== 0) {
        return 0;
    }

    if (ones === 0) {
        return (BigInt(n - 1) * BigInt(n - 2) / 2n) % 1000000007n;
    }

    const targetOnes = ones / 3;
    let firstCut = 0;
    let secondCut = 0;
    let currentOnes = 0;

    for (let i = 0; i < n; i++) {
        if (s[i] === '1') {
            currentOnes++;
        }
        if (currentOnes === targetOnes) {
            firstCut++;
        } else if (currentOnes === 2 * targetOnes) {
            secondCut++;
        }
    }

    return (BigInt(firstCut) * BigInt(secondCut)) % 1000000007n;
};