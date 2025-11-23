var removeKdigits = function(num, k) {
    const stack = [];
    for (const digit of num) {
        while (stack.length > 0 && k > 0 && stack[stack.length - 1] > digit) {
            stack.pop();
            k--;
        }
        stack.push(digit);
    }
    while (k > 0) {
        stack.pop();
        k--;
    }
    let result = stack.join('').replace(/^0+/, '');
    return result === '' ? '0' : result;
};