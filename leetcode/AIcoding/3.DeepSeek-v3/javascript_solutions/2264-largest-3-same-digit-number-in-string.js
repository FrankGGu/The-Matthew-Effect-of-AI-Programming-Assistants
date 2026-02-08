var largestGoodInteger = function(num) {
    let max = '';
    for (let i = 0; i < num.length - 2; i++) {
        if (num[i] === num[i + 1] && num[i] === num[i + 2]) {
            const current = num.substring(i, i + 3);
            if (current > max) {
                max = current;
            }
        }
    }
    return max;
};