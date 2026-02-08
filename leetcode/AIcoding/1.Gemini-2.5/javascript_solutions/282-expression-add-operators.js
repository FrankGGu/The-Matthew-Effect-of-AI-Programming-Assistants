var addOperators = function(num, target) {
    const result = [];
    const targetBigInt = BigInt(target);

    function backtrack(index, currentPath, currentVal, lastOperand) {
        if (index === num.length) {
            if (currentVal === targetBigInt) {
                result.push(currentPath);
            }
            return;
        }

        for (let i = index; i < num.length; i++) {
            const currentNumStr = num.substring(index, i + 1);

            if (currentNumStr.length > 1 && currentNumStr[0] === '0') {
                break; 
            }

            const currentNum = BigInt(currentNumStr);

            if (index === 0) {
                backtrack(i + 1, currentNumStr, currentNum, currentNum);
            } else {
                // Add operator '+'
                backtrack(i + 1, currentPath + '+' + currentNumStr, currentVal + currentNum, currentNum);

                // Add operator '-'
                backtrack(i + 1, currentPath + '-' + currentNumStr, currentVal - currentNum, -currentNum);

                // Add operator '*'
                backtrack(i + 1, currentPath + '*' + currentNumStr, currentVal - lastOperand + (lastOperand * currentNum), lastOperand * currentNum);
            }
        }
    }

    if (num.length === 0) {
        return [];
    }

    backtrack(0, "", 0n, 0n);

    return result;
};