var subarrayGCD = function(nums, k) {
    let count = 0;
    const n = nums.length;
    for (let i = 0; i < n; i++) {
        let currentGcd = nums[i];
        for (let j = i; j < n; j++) {
            currentGcd = gcd(currentGcd, nums[j]);
            if (currentGcd === k) {
                count++;
            } else if (currentGcd < k) {
                break;
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