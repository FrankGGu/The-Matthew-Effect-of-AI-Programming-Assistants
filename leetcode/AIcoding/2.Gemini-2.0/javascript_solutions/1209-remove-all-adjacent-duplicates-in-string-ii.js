var removeDuplicates = function(s, k) {
    const stack = [];
    for (let char of s) {
        if (stack.length > 0 && stack[stack.length - 1][0] === char) {
            stack[stack.length - 1][1]++;
            if (stack[stack.length - 1][1] === k) {
                stack.pop();
            }
        } else {
            stack.push([char, 1]);
        }
    }
    let result = "";
    for (let [char, count] of stack) {
        result += char.repeat(count);
    }
    return result;
};