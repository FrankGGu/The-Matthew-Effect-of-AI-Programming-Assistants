var supplyWagon = function(supplies, n) {
    let len = supplies.length;
    let remove = len - n;
    let stack = [];

    for (let i = 0; i < len; i++) {
        while (stack.length > 0 && remove > 0 && stack[stack.length - 1] > supplies[i]) {
            stack.pop();
            remove--;
        }
        stack.push(supplies[i]);
    }

    while (remove > 0) {
        stack.pop();
        remove--;
    }

    return stack;
};