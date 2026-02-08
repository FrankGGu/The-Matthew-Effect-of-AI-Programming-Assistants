var countSubsequences = function(nums) {
    const MOD = 1e9 + 7;
    const n = nums.length;
    nums.sort((a, b) => a - b);
    let count = 0;

    for (let g = 1; g <= 100000; g++) {
        let valid = [];
        for (let num of nums) {
            if (num % g === 0) valid.push(num);
        }
        if (valid.length === 0) continue;

        const total = valid.length;
        let gcdCount = 0;

        for (let i = total - 1; i >= 0; i--) {
            let tempGcd = valid[i];
            for (let j = i - 1; j >= 0; j--) {
                tempGcd = gcd(tempGcd, valid[j]);
                if (tempGcd === g) {
                    gcdCount++;
                }
            }
            gcdCount++; // for the single element case
        }

        if (gcdCount > 0) {
            count = (count + gcdCount) % MOD;
        }
    }

    return count;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}