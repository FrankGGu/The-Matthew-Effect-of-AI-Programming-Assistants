var singleNumber = function(nums) {
    let ones = 0;
    let twos = 0;

    for (const num of nums) {
        twos |= (ones & num);
        ones ^= num;

        let threes = ones & twos;

        ones &= ~threes;
        twos &= ~threes;
    }

    return ones;
};