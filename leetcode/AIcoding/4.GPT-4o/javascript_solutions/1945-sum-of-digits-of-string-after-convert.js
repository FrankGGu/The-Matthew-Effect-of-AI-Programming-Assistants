var getLucky = function(s, k) {
    const convert = s.split('').map(c => c.charCodeAt(0) - 96).join('');
    let sum = convert.split('').reduce((acc, num) => acc + Number(num), 0);

    for (let i = 1; i < k; i++) {
        sum = sum.toString().split('').reduce((acc, num) => acc + Number(num), 0);
    }

    return sum;
};