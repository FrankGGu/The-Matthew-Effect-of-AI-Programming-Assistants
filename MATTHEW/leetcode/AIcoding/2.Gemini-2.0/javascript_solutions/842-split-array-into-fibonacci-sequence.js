var splitIntoFibonacci = function(s) {
    let n = s.length;
    let result = [];

    function backtrack(index, sequence) {
        if (index === n && sequence.length >= 3) {
            result = sequence;
            return true;
        }

        for (let i = index; i < n; i++) {
            let numStr = s.substring(index, i + 1);
            if (numStr.length > 1 && numStr[0] === '0') {
                continue;
            }

            let num = parseInt(numStr);
            if (num > Math.pow(2, 31) - 1) {
                break;
            }

            if (sequence.length >= 2) {
                let sum = sequence[sequence.length - 1] + sequence[sequence.length - 2];
                if (num < sum) {
                    continue;
                } else if (num > sum) {
                    break;
                }
            }

            sequence.push(num);
            if (backtrack(i + 1, sequence)) {
                return true;
            }
            sequence.pop();
        }

        return false;
    }

    backtrack(0, []);
    return result;
};