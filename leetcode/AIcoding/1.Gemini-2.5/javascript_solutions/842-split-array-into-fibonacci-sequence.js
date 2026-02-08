var splitIntoFibonacci = function(S) {
    const result = [];
    const MAX_INT = 2**31 - 1;

    function backtrack(index) {
        if (index === S.length) {
            return result.length >= 3;
        }

        for (let i = index; i < S.length; i++) {
            if (S[index] === '0' && i > index) {
                break;
            }

            const numStr = S.substring(index, i + 1);
            const num = parseInt(numStr, 10);

            if (num > MAX_INT) {
                break;
            }

            if (result.length < 2) {
                result.push(num);
                if (backtrack(i + 1)) {
                    return true;
                }
                result.pop();
            } else {
                const prev1 = result[result.length - 2];
                const prev2 = result[result.length - 1];
                const expected = prev1 + prev2;

                if (num < expected) {
                    continue;
                }
                if (num > expected) {
                    break;
                }

                result.push(num);
                if (backtrack(i + 1)) {
                    return true;
                }
                result.pop();
            }
        }
        return false;
    }

    backtrack(0);
    return result;
};