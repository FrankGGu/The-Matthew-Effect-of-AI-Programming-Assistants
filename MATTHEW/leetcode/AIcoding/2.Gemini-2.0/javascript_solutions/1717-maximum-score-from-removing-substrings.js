var maximumGain = function(s, x, y) {
    let score = 0;
    let stack1 = [];
    let stack2 = [];
    let a = "ab";
    let b = "ba";
    if (x < y) {
        [x, y] = [y, x];
        [a, b] = [b, a];
    }

    for (let char of s) {
        stack1.push(char);
        while (stack1.length >= 2) {
            let last2 = stack1.slice(-2).join('');
            if (last2 === a) {
                stack1.pop();
                stack1.pop();
                score += x;
            } else {
                break;
            }
        }
    }

    while (stack1.length > 0) {
        let char = stack1.shift();
        stack2.push(char);
        while (stack2.length >= 2) {
            let last2 = stack2.slice(-2).join('');
            if (last2 === b) {
                stack2.pop();
                stack2.pop();
                score += y;
            } else {
                break;
            }
        }
    }

    return score;
};