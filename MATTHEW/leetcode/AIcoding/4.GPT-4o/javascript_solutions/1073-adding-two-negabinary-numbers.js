var addNegabinary = function(arr1, arr2) {
    let carry = 0;
    let result = [];
    let i = arr1.length - 1, j = arr2.length - 1;

    while (i >= 0 || j >= 0 || carry !== 0) {
        let sum = carry;
        if (i >= 0) sum += arr1[i--];
        if (j >= 0) sum += arr2[j--];

        if (sum >= 2) {
            sum -= 2;
            carry = -1;
        } else if (sum <= -1) {
            sum += 2;
            carry = 1;
        } else {
            carry = 0;
        }

        result.push(sum);
    }

    while (result.length > 1 && result[result.length - 1] === 0) {
        result.pop();
    }

    return result.reverse();
};