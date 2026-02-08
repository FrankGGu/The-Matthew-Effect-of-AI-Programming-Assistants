var getHappyString = function(n, k) {
    let count = 0;
    let result = "";

    function backtrack(str) {
        if (str.length === n) {
            count++;
            if (count === k) {
                result = str;
            }
            return;
        }

        if (count >= k) return;

        let chars = ['a', 'b', 'c'];
        for (let char of chars) {
            if (str.length > 0 && str[str.length - 1] === char) continue;
            backtrack(str + char);
        }
    }

    backtrack("");

    return result;
};