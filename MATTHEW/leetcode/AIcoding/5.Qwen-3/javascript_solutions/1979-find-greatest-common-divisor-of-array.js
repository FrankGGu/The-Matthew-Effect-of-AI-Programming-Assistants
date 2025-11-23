function findGCD(nums) {
    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    let min = Math.min(...nums);
    let max = Math.max(...nums);
    return gcd(max, min);
}