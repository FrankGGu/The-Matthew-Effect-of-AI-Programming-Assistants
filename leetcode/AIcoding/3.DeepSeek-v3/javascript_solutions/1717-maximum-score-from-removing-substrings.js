var maximumGain = function(s, x, y) {
    let a = 'a', b = 'b';
    if (x < y) {
        [a, b] = [b, a];
        [x, y] = [y, x];
    }
    let res = 0;
    let stack1 = [];
    for (const ch of s) {
        if (stack1.length > 0 && stack1[stack1.length - 1] === a && ch === b) {
            stack1.pop();
            res += x;
        } else {
            stack1.push(ch);
        }
    }
    let stack2 = [];
    for (const ch of stack1) {
        if (stack2.length > 0 && stack2[stack2.length - 1] === b && ch === a) {
            stack2.pop();
            res += y;
        } else {
            stack2.push(ch);
        }
    }
    return res;
};