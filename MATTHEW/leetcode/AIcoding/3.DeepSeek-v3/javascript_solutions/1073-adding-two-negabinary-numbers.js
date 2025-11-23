var addNegabinary = function(arr1, arr2) {
    let i = arr1.length - 1;
    let j = arr2.length - 1;
    let carry = 0;
    const result = [];

    while (i >= 0 || j >= 0 || carry !== 0) {
        let sum = carry;
        if (i >= 0) sum += arr1[i--];
        if (j >= 0) sum += arr2[j--];

        result.unshift(sum & 1);
        carry = -(sum >> 1);
    }

    while (result.length > 1 && result[0] === 0) {
        result.shift();
    }

    return result;
};