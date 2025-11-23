var removeKdigits = function(num, k) {
    const stack = [];
    for (let digit of num) {
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

    let result = stack.join('');
    while (result.length > 1 && result[0] === '0') {
        result = result.substring(1);
    }

    return result.length === 0 ? '0' : result;
};