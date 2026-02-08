var countDifferentSubsequenceGCDs = function(nums) {
    const maxNum = Math.max(...nums);
    const numSet = new Set(nums);
    let count = 0;

    for (let x = 1; x <= maxNum; x++) {
        let currentGcd = 0;
        for (let multiple = x; multiple <= maxNum; multiple += x) {
            if (numSet.has(multiple)) {
                currentGcd = gcd(currentGcd, multiple);
                if (currentGcd === x) {
                    count++;
                    break;
                }
            }
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