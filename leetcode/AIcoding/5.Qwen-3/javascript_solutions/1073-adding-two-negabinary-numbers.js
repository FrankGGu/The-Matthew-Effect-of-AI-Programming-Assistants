function addNegabinary(a, b) {
    const result = [];
    let i = a.length - 1;
    let j = b.length - 1;
    let carry = 0;

    while (i >= 0 || j >= 0 || carry !== 0) {
        let sum = carry;
        if (i >= 0) sum += a[i];
        if (j >= 0) sum += b[j];
        result.unshift(sum % 2);
        carry = -(sum / 2 | 0);
        i--;
        j--;
    }

    while (result.length > 1 && result[0] === 0) {
        result.shift();
    }

    return result;
}