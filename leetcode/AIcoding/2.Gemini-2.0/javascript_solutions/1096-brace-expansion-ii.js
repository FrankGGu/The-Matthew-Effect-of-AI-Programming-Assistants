var braceExpansionII = function(expression) {
    function evaluate(s, start, end) {
        let results = new Set();
        let i = start;
        let current = new Set();
        current.add("");

        while (i <= end) {
            if (s[i] === ',') {
                for (let str of current) {
                    results.add(str);
                }
                current = new Set();
                current.add("");
                i++;
            } else if (s[i] === '{') {
                let count = 1;
                let j = i + 1;
                while (j <= end && count > 0) {
                    if (s[j] === '{') {
                        count++;
                    } else if (s[j] === '}') {
                        count--;
                    }
                    j++;
                }
                j--;
                let subResults = evaluate(s, i + 1, j - 1);
                let newCurrent = new Set();
                for (let str1 of current) {
                    for (let str2 of subResults) {
                        newCurrent.add(str1 + str2);
                    }
                }
                current = newCurrent;
                i = j + 1;
            } else {
                let newCurrent = new Set();
                for (let str of current) {
                    newCurrent.add(str + s[i]);
                }
                current = newCurrent;
                i++;
            }
        }

        for (let str of current) {
            results.add(str);
        }

        return results;
    }

    let result = Array.from(evaluate(expression, 0, expression.length - 1));
    result.sort();
    return result;
};