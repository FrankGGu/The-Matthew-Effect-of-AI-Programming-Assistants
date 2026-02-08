var addNegabinary = function(arr1, arr2) {
    let i = arr1.length - 1;
    let j = arr2.length - 1;
    let carry = 0;
    const result = [];

    while (i >= 0 || j >= 0 || carry !== 0) {
        const digit1 = i >= 0 ? arr1[i] : 0;
        const digit2 = j >= 0 ? arr2[j] : 0;

        const sum = digit1 + digit2 + carry;

        switch (sum) {
            case 0:
                result.push(0);
                carry = 0;
                break;
            case 1:
                result.push(1);
                carry = 0;
                break;
            case 2:
                result.push(0);
                carry = -1;
                break;
            case 3:
                result.push(1);
                carry = -1;
                break;
            case -1:
                result.push(1);
                carry = 1;
                break;
        }

        i--;
        j--;
    }

    while (result.length > 1 && result[result.length - 1] === 0) {
        result.pop();
    }

    return result.reverse();
};