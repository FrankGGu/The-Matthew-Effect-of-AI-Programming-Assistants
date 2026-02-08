var removeKdigits = function(num, k) {
    const stack = [];
    for (let digit of num) {
        while (k > 0 && stack.length && stack[stack.length - 1] > digit) {
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
    return result.length ? result : '0';
};