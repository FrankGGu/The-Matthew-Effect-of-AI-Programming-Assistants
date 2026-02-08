var stableBinaryArrays = function(n) {
    const result = [];
    const backtrack = (current, oneCount) => {
        if (current.length === n) {
            result.push(current.join(''));
            return;
        }
        if (oneCount < Math.floor(n / 2)) {
            backtrack([...current, 1], oneCount + 1);
        }
        if (current.length < 2 || current[current.length - 1] === 0) {
            backtrack([...current, 0], oneCount);
        }
    };
    backtrack([], 0);
    return result;
};