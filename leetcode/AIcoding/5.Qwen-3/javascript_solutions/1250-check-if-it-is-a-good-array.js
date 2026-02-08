function isGoodArray(nums) {
    let gcd = nums[0];
    for (let i = 1; i < nums.length; i++) {
        gcd = gcdFunction(gcd, nums[i]);
    }
    return gcd === 1;
}

function gcdFunction(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}