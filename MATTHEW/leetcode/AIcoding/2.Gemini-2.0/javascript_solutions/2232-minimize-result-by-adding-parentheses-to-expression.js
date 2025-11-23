var minimizeResult = function(expression) {
    let plusIndex = expression.indexOf('+');
    let left = expression.substring(0, plusIndex);
    let right = expression.substring(plusIndex + 1);
    let minVal = Infinity;
    let minStr = "";

    for (let i = 0; i < left.length; i++) {
        for (let j = 0; j < right.length; j++) {
            let leftNum1 = (i > 0) ? parseInt(left.substring(0, i)) : 1;
            let leftNum2 = parseInt(left.substring(i));
            let rightNum1 = parseInt(right.substring(0, j + 1));
            let rightNum2 = (j < right.length - 1) ? parseInt(right.substring(j + 1)) : 1;

            let currentVal = leftNum1 * (leftNum2 + rightNum1) * rightNum2;

            if (currentVal < minVal) {
                minVal = currentVal;
                minStr = (i > 0 ? left.substring(0, i) : "") + "(" + left.substring(i) + "+" + right.substring(0, j + 1) + ")" + (j < right.length - 1 ? right.substring(j + 1) : "");
            }
        }
    }

    return minStr;
};