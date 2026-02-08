var splitIntoFibonacci = function(num) {
    const res = [];
    const backtrack = (index, prev1, prev2, path) => {
        if (index === num.length) {
            if (path.length >= 3) {
                res.push(...path);
                return true;
            }
            return false;
        }
        let current = 0;
        for (let i = index; i < num.length; i++) {
            if (i > index && num[index] === '0') break;
            current = current * 10 + parseInt(num[i]);
            if (current > 2**31 - 1) break;
            if (path.length >= 2) {
                const sum = prev1 + prev2;
                if (current < sum) continue;
                if (current > sum) break;
            }
            path.push(current);
            if (backtrack(i + 1, prev2, current, path)) {
                return true;
            }
            path.pop();
        }
        return false;
    };
    backtrack(0, 0, 0, []);
    return res;
};