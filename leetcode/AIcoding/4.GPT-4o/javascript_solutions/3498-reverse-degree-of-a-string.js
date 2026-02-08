function reverseDegree(s) {
    const stack = [];
    const result = [];

    for (const char of s) {
        if (char === '(') {
            stack.push(result.length);
            result.push('');
        } else if (char === ')') {
            const last = result.pop();
            const start = stack.pop();
            result[start] = last.split('').reverse().join('');
        } else {
            if (result.length === 0) {
                result.push('');
            }
            result[result.length - 1] += char;
        }
    }

    return result.join('');
}