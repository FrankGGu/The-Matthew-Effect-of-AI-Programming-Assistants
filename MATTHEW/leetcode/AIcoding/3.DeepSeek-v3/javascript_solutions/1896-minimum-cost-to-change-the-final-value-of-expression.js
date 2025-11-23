var minOperationsToFlip = function(expression) {
    const n = expression.length;
    const stack = [];
    const dp = Array(n).fill(0).map(() => [0, 0]);
    const op = [];

    for (let i = 0; i < n; i++) {
        const c = expression[i];
        if (c === '(' || c === '&' || c === '|') {
            stack.push(i);
        } else if (c === ')') {
            op.pop();
            stack.pop();
        } else if (c === '0' || c === '1') {
            const val = parseInt(c);
            dp[i][val] = 0;
            dp[i][1 - val] = 1;
            if (stack.length > 0 && expression[stack[stack.length - 1]] !== '(') {
                const j = op.pop();
                const left = stack.pop();
                const right = i;
                const [l0, l1] = dp[left];
                const [r0, r1] = dp[right];
                const opChar = expression[j];
                let new0, new1;
                if (opChar === '&') {
                    new0 = Math.min(l0 + r0, l0 + r1, l1 + r0);
                    new1 = l1 + r1;
                } else {
                    new0 = l0 + r0;
                    new1 = Math.min(l1 + r0, l0 + r1, l1 + r1);
                }
                const flip0 = Math.min(l0 + r0 + 1, l1 + r1 + 1);
                const flip1 = Math.min(l0 + r1 + 1, l1 + r0 + 1);
                dp[left][0] = Math.min(new0, flip0);
                dp[left][1] = Math.min(new1, flip1);
                stack.push(left);
            }
        }
        if (i + 1 < n && (expression[i + 1] === '&' || expression[i + 1] === '|')) {
            op.push(i + 1);
        }
    }

    const root = stack.pop();
    const [res0, res1] = dp[root];
    return Math.max(res0, res1);
};