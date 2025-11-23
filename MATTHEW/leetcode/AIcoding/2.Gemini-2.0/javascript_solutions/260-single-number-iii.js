var singleNumber = function(nums) {
    let xor = 0;
    for (let num of nums) {
        xor ^= num;
    }

    let rightmostSetBit = xor & -xor;

    let num1 = 0;
    let num2 = 0;

    for (let num of nums) {
        if (num & rightmostSetBit) {
            num1 ^= num;
        } else {
            num2 ^= num;
        }
    }

    return [num1, num2];
};