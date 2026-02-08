function numWays(s) {
    const mod = 1e9 + 7;
    const countOnes = s.split('').reduce((acc, char) => acc + (char === '1' ? 1 : 0), 0);

    if (countOnes === 0) {
        return (BigInt(s.length - 1) * BigInt(s.length - 2) / BigInt(2)) % BigInt(mod);
    }

    if (countOnes % 3 !== 0) {
        return 0;
    }

    const target = countOnes / 3;
    let firstPart = 0, secondPart = 0, currentOnes = 0;

    for (let char of s) {
        if (char === '1') currentOnes++;
        if (currentOnes === target) firstPart++;
        if (currentOnes === target * 2) secondPart++;
    }

    return (firstPart * secondPart) % mod;
}