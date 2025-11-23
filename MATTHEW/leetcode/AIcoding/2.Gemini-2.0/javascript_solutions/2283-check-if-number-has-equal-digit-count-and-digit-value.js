var digitCount = function(num) {
    for (let i = 0; i < num.length; i++) {
        let count = 0;
        for (let j = 0; j < num.length; j++) {
            if (parseInt(num[j]) === i) {
                count++;
            }
        }
        if (count !== parseInt(num[i])) {
            return false;
        }
    }
    return true;
};