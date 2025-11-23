var getHappyString = function(n, k) {
    let count = 0;
    let result = "";

    function backtrack(currentString) {
        if (result !== "") {
            return;
        }

        if (currentString.length === n) {
            count++;
            if (count === k) {
                result = currentString;
            }
            return;
        }

        const chars = ['a', 'b', 'c'];
        for (const char of chars) {
            if (currentString.length === 0 || char !== currentString[currentString.length - 1]) {
                backtrack(currentString + char);
                if (result !== "") {
                    return;
                }
            }
        }
    }

    backtrack("");
    return result;
};