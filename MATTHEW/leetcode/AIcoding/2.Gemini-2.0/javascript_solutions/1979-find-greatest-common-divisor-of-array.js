var findGCD = function(nums) {
    let min = Math.min(...nums);
    let max = Math.max(...nums);

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }

    return gcd(max, min);
};