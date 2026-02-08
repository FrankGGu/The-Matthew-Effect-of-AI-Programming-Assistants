var minOperations = function(nums) {
    let n = nums.length;
    let ones = nums.filter(x => x === 1).length;
    if (ones > 0) {
        return n - ones;
    }

    let minOps = Infinity;
    for (let i = 0; i < n; i++) {
        let g = nums[i];
        for (let j = i + 1; j < n; j++) {
            g = gcd(g, nums[j]);
            if (g === 1) {
                minOps = Math.min(minOps, j - i + (n - 1));
                break;
            }
        }
    }

    return minOps === Infinity ? -1 : minOps;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}