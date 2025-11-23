var replaceNonCoprimes = function(nums) {
    const stack = [];
    for (let num of nums) {
        let current = num;
        while (stack.length > 0) {
            const top = stack[stack.length - 1];
            const gcdValue = gcd(current, top);
            if (gcdValue === 1) break;
            current = (current * top) / gcdValue;
            stack.pop();
        }
        stack.push(current);
    }
    return stack;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}