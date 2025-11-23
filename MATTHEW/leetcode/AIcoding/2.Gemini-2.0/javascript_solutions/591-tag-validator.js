var isValid = function(code) {
    code = code.replace(/<!\[CDATA\[.*?\]\]>/g, ' ');
    let stack = [];
    let i = 0;
    while (i < code.length) {
        if (code.startsWith('</', i)) {
            let j = i + 2;
            while (j < code.length && code[j] !== '>') {
                j++;
            }
            if (j === code.length) return false;
            let tagName = code.substring(i + 2, j);
            if (stack.length === 0 || stack.pop() !== tagName) return false;
            i = j + 1;
            if (stack.length === 0 && i < code.length) return false;
        } else if (code.startsWith('<', i)) {
            let j = i + 1;
            while (j < code.length && code[j] !== '>') {
                j++;
            }
            if (j === code.length) return false;
            let tagName = code.substring(i + 1, j);
            if (tagName.length < 1 || tagName.length > 9 || !/^[A-Z]+$/.test(tagName)) return false;
            stack.push(tagName);
            i = j + 1;
        } else {
            if (stack.length === 0) return false;
            i++;
        }
    }
    return stack.length === 0;
};