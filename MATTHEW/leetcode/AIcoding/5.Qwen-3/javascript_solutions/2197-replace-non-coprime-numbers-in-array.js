function replaceNonCoprimeNumbersInArray(nums) {
    const stack = [];

    for (let num of nums) {
        while (stack.length > 0) {
            const top = stack[stack.length - 1];
            const gcd = function(a, b) {
                while (b !== 0) {
                    let temp = b;
                    b = a % b;
                    a = temp;
                }
                return a;
            }(top, num);

            if (gcd === 1) {
                break;
            } else {
                num = Math.floor(top * num / gcd);
                stack.pop();
            }
        }
        stack.push(num);
    }

    return stack;
}