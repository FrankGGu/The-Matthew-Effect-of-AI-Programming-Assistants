function countDifferentSubsequenceGCDs(nums) {
    const maxNum = Math.max(...nums);
    const seen = new Set(nums);
    let result = 0;

    for (let g = 1; g <= maxNum; g++) {
        let currentGCD = 0;
        for (let i = g; i <= maxNum; i += g) {
            if (seen.has(i)) {
                currentGCD = gcd(currentGCD, i);
                if (currentGCD === g) {
                    result++;
                    break;
                }
            }
        }
    }

    return result;
}

function gcd(a, b) {
    while (b !== 0) {
        const temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}