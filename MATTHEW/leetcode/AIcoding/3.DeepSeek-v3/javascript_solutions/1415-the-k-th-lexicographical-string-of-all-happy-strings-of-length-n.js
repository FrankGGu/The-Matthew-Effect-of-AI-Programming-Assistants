var getHappyString = function(n, k) {
    const chars = ['a', 'b', 'c'];
    let count = 0;
    let result = "";

    function backtrack(current) {
        if (current.length === n) {
            count++;
            if (count === k) {
                result = current;
            }
            return;
        }

        for (const char of chars) {
            if (current.length === 0 || current[current.length - 1] !== char) {
                backtrack(current + char);
                if (result !== "") {
                    return;
                }
            }
        }
    }

    backtrack("");
    return result;
};