var decodeString = function(s) {
    const stack = [];

    for (const char of s) {
        if (char !== ']') {
            stack.push(char);
        } else {
            let decodedString = '';
            while (stack[stack.length - 1] !== '[') {
                decodedString = stack.pop() + decodedString;
            }
            stack.pop(); // Remove '['

            let num = '';
            while (stack.length > 0 && !isNaN(parseInt(stack[stack.length - 1]))) {
                num = stack.pop() + num;
            }
            num = parseInt(num);

            let repeatedString = '';
            for (let i = 0; i < num; i++) {
                repeatedString += decodedString;
            }

            stack.push(repeatedString);
        }
    }

    return stack.join('');
};