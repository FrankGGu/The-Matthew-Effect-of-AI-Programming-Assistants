function removeAlmostEqualCharacters(s) {
    const stack = [];
    for (let i = 0; i < s.length; i++) {
        if (stack.length > 0 && Math.abs(s.charCodeAt(i) - s.charCodeAt(stack[stack.length - 1])) <= 1) {
            stack.pop();
        } else {
            stack.push(i);
        }
    }
    return s.split('').filter((_, i) => stack.includes(i)).join('');
}