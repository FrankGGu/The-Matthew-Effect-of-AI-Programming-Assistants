var theTwoSneakyNumbers = function(arr) {
    let xor = 0;
    for (let num of arr) {
        xor ^= num;
    }

    let rightmostSetBit = xor & -xor;

    let num1 = 0;
    let num2 = 0;

    for (let num of arr) {
        if (num & rightmostSetBit) {
            num1 ^= num;
        } else {
            num2 ^= num;
        }
    }

    return [Math.min(num1, num2), Math.max(num1, num2)];
};