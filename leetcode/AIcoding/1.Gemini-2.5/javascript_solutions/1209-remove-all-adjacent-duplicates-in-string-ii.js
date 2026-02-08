var removeDuplicates = function(s, k) {
    const stack = [];

    for (let i = 0; i < s.length; i++) {
        const char = s[i];

        if (stack.length > 0 && stack[stack.length - 1][0] === char) {
            stack[stack.length - 1][1]++;
        } else {
            stack.push([char, 1]);
        }

        if (stack.length > 0 && stack[stack.length - 1][1] === k) {
            stack.pop();
        }
    }

    let result = "";
    for (const [char, count] of stack) {
        result += char.repeat(count);
    }

    return result;
};