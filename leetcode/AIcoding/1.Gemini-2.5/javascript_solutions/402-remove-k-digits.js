var removeKdigits = function(num, k) {
    const stack = [];

    for (const digit of num) {
        while (k > 0 && stack.length > 0 && stack[stack.length - 1] > digit) {
            stack.pop();
            k--;
        }
        stack.push(digit);
    }

    while (k > 0) {
        stack.pop();
        k--;
    }

    let result = stack.join('');
    let i = 0;
    while (i < result.length - 1 && result[i] === '0') {
        i++;
    }
    result = result.substring(i);

    return result === '' ? '0' : result;
};