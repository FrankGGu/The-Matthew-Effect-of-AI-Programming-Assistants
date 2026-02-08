var countIntegers = function(min, max, key) {
    let count = 0;
    for (let i = min; i <= max; i++) {
        if ((i ^ key) >= min && (i ^ key) <= max) {
            count++;
        }
    }
    return count;
};