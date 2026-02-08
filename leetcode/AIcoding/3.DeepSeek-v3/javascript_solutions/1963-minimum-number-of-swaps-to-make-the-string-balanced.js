var minSwaps = function(s) {
    let balance = 0, swaps = 0;
    for (let char of s) {
        if (char === '[') {
            balance++;
        } else {
            if (balance > 0) {
                balance--;
            } else {
                swaps++;
                balance++;
            }
        }
    }
    return Math.ceil(swaps / 2);
};