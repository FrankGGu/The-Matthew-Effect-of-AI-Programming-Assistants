var largeGroupPositions = function(s) {
    const result = [];
    let i = 0;
    for (let j = 0; j < s.length; j++) {
        if (j === s.length - 1 || s[j] !== s[j + 1]) {
            if (j - i + 1 >= 3) {
                result.push([i, j]);
            }
            i = j + 1;
        }
    }
    return result;
};