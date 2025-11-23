var addNegabinary = function(arr1, arr2) {
    let result = [];
    let i = arr1.length - 1;
    let j = arr2.length - 1;
    let carry = 0;

    while (i >= 0 || j >= 0 || carry !== 0) {
        let bit1 = i >= 0 ? arr1[i] : 0;
        let bit2 = j >= 0 ? arr2[j] : 0;

        let currentSum = bit1 + bit2 + carry;

        // Determine the current digit (s) and the new carry for base -2
        // currentSum = s + carry_out * (-2)
        if (currentSum === -1) { // -1 = 1 + 1 * (-2)
            result.push(1);
            carry = 1;
        } else if (currentSum === 0) { // 0 = 0 + 0 * (-2)
            result.push(0);
            carry = 0;
        } else if (currentSum === 1) { // 1 = 1 + 0 * (-2)
            result.push(1);
            carry = 0;
        } else if (currentSum === 2) { // 2 = 0 + (-1) * (-2)
            result.push(0);
            carry = -1;
        } else if (currentSum === 3) { // 3 = 1 + (-1) * (-2)
            result.push(1);
            carry = -1;
        }

        i--;
        j--;
    }

    // Remove leading zeros from the result, unless the result is just [0]
    // The result array is built in reverse order, so we pop from the end
    while (result.length > 1 && result[result.length - 1] === 0) {
        result.pop();
    }

    return result.reverse();
};