var largeGroupPositions = function(s) {
    let result = [];
    let start = 0;

    for (let i = 0; i < s.length; i++) {
        if (i === s.length - 1 || s[i] !== s[i + 1]) {
            if (i - start + 1 >= 3) {
                result.push([start, i]);
            }
            start = i + 1;
        }
    }

    return result;
};