var largestGoodInteger = function(num) {
    let maxGoodInteger = "";
    for (let i = 0; i < num.length - 2; i++) {
        if (num[i] === num[i + 1] && num[i] === num[i + 2]) {
            if (num[i] > maxGoodInteger) {
                maxGoodInteger = num[i];
            }
        }
    }
    return maxGoodInteger ? maxGoodInteger.repeat(3) : "";
};