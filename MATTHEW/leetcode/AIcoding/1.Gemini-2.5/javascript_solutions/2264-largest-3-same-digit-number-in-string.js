var largestGoodInteger = function(num) {
    for (let i = 9; i >= 0; i--) {
        const target = String(i) + String(i) + String(i);
        if (num.includes(target)) {
            return target;
        }
    }
    return "";
};