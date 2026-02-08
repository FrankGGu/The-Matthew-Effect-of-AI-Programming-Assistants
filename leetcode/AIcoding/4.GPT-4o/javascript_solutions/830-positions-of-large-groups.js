var largeGroupPositions = function(S) {
    let result = [];
    let start = 0;

    for (let i = 1; i <= S.length; i++) {
        if (i === S.length || S[i] !== S[start]) {
            if (i - start >= 3) {
                result.push([start, i - 1]);
            }
            start = i;
        }
    }

    return result;
};