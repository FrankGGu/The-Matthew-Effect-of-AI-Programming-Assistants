function evenOddBit(nums) {
    let even = 0;
    let odd = 0;
    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];
        for (let j = 0; j < 32; j++) {
            if ((num >> j) & 1) {
                if (j % 2 === 0) {
                    even++;
                } else {
                    odd++;
                }
            }
        }
    }
    return [even, odd];
}