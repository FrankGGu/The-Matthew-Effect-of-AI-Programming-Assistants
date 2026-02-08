var countDifferentSubsequenceGCDs = function(nums) {
    const maxNum = Math.max(...nums);
    const seen = new Array(maxNum + 1).fill(false);
    for (let num of nums) {
        seen[num] = true;
    }

    let count = 0;
    for (let g = 1; g <= maxNum; g++) {
        let currentGCD = 0;
        for (let multiple = g; multiple <= maxNum; multiple += g) {
            if (seen[multiple]) {
                currentGCD = gcd(currentGCD, multiple);
            }
        }
        if (currentGCD === g) {
            count++;
        }
    }

    return count;
};

function gcd(a, b) {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
}