var minimizeResult = function(expression) {
    const plusIndex = expression.indexOf('+');
    const leftStr = expression.substring(0, plusIndex);
    const rightStr = expression.substring(plusIndex + 1);

    let minVal = Infinity;
    let minExpr = "";

    // i represents the split point for the left string.
    // leftStr.substring(0, i) is the prefix before the opening parenthesis.
    // leftStr.substring(i) is the part inside the parenthesis on the left side.
    for (let i = 0; i < leftStr.length; i++) {
        const L_prefix_str = leftStr.substring(0, i);
        const L_middle_str = leftStr.substring(i);
        const numL_prefix = L_prefix_str === "" ? 1 : parseInt(L_prefix_str);
        const numL_middle = parseInt(L_middle_str);

        // j represents the split point for the right string.
        // rightStr.substring(0, j) is the part inside the parenthesis on the right side.
        // rightStr.substring(j) is the suffix after the closing parenthesis.
        for (let j = 1; j <= rightStr.length; j++) {
            const R_middle_str = rightStr.substring(0, j);
            const R_suffix_str = rightStr.substring(j);
            const numR_middle = parseInt(R_middle_str);
            const numR_suffix = R_suffix_str === "" ? 1 : parseInt(R_suffix_str);

            const currentVal = numL_prefix * (numL_middle + numR_middle) * numR_suffix;

            if (currentVal < minVal) {
                minVal = currentVal;
                minExpr = L_prefix_str + "(" + L_middle_str + "+" + R_middle_str + ")" + R_suffix_str;
            }
        }
    }

    return minExpr;
};