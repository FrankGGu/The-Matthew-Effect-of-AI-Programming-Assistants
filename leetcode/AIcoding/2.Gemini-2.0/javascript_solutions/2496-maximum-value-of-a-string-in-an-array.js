var maximumValue = function(strs) {
    let max = 0;
    for (let str of strs) {
        let num = parseInt(str);
        if (isNaN(num)) {
            max = Math.max(max, str.length);
        } else {
            max = Math.max(max, num);
        }
    }
    return max;
};