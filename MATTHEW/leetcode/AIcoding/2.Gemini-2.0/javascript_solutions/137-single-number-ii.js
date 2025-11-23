var singleNumber = function(nums) {
    let seenOnce = 0;
    let seenTwice = 0;

    for (let num of nums) {
        seenOnce = ~seenTwice & (seenOnce ^ num);
        seenTwice = ~seenOnce & (seenTwice ^ num);
    }

    return seenOnce;
};