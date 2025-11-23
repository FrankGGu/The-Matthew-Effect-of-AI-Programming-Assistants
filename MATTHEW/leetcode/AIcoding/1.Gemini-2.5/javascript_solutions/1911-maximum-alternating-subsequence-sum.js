var maxAlternatingSum = function(nums) {
    let add = 0;      // Maximum alternating sum ending with an element being added
    let subtract = 0; // Maximum alternating sum ending with an element being subtracted

    for (let num of nums) {
        // Calculate the new 'add' state:
        // Option 1: Do not include the current 'num' as the last added element.
        //           The max sum ending with an addition remains the previous 'add'.
        // Option 2: Include the current 'num' as the last added element.
        //           This means 'num' is added to a subsequence that previously ended with a subtraction.
        //           The sum would be 'subtract + num'.
        //           If 'subtract' is 0, it means starting a new subsequence with 'num'.
        let newAdd = Math.max(add, subtract + num);

        // Calculate the new 'subtract' state:
        // Option 1: Do not include the current 'num' as the last subtracted element.
        //           The max sum ending with a subtraction remains the previous 'subtract'.
        // Option 2: Include the current 'num' as the last subtracted element.
        //           This means 'num' is subtracted from a subsequence that previously ended with an addition.
        //           The sum would be 'add - num'.
        //           If 'add' is 0, 'add - num' would be negative, and Math.max(0, negative) would be 0,
        //           correctly preventing a subsequence from starting with a subtraction.
        let newSubtract = Math.max(subtract, add - num);

        add = newAdd;
        subtract = newSubtract;
    }

    // The problem asks for the maximum alternating subsequence sum.
    // An alternating subsequence always starts with an addition.
    // If the maximum sum ended with a subtraction (e.g., ... + X - Y),
    // then the subsequence ending at X (... + X) would be a valid alternating
    // subsequence with a sum of at least X. Since Y is positive, X is greater than X-Y.
    // Thus, the maximum sum will always be found in the 'add' state.
    return add;
};