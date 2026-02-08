var splitIntoFibonacci = function(S) {
    const result = [];

    const backtrack = (start) => {
        if (result.length >= 3 && start === S.length) {
            return true;
        }

        let num = 0;
        for (let i = start; i < S.length; i++) {
            num = num * 10 + (S[i] - '0');
            if (num > 0 && String(num).length !== i - start + 1) break;
            if (num > 2147483647) break;

            if (result.length < 2 || num === result[result.length - 1] + result[result.length - 2]) {
                result.push(num);
                if (backtrack(i + 1)) {
                    return true;
                }
                result.pop();
            }
        }
        return false;
    };

    backtrack(0);
    return result.length >= 3 ? result : [];
};