const scoreOfStudents = function(s, answers) {
    const n = s.length;
    const numCount = Math.floor((n + 1) / 2);
    const dp = Array.from({ length: numCount }, () => Array(numCount).fill(0));

    for (let i = 0; i < numCount; i++) {
        dp[i][i] = parseInt(s[i * 2]);
    }

    for (let len = 1; len < numCount; len++) {
        for (let left = 0; left + len < numCount; left++) {
            const right = left + len;
            const set = new Set();
            for (let k = left; k < right; k++) {
                const op = s[k * 2 + 1];
                const leftVals = dp[left][k];
                const rightVals = dp[k + 1][right];
                for (const l of leftVals instanceof Set ? leftVals : [leftVals]) {
                    for (const r of rightVals instanceof Set ? rightVals : [rightVals]) {
                        const res = op === '+' ? l + r : l * r;
                        if (res <= 1000) set.add(res);
                    }
                }
            }
            dp[left][right] = set;
        }
    }

    const correct = calculateCorrect(s);
    const possible = dp[0][numCount - 1];
    let score = 0;

    for (const ans of answers) {
        if (ans === correct) {
            score += 5;
        } else if (possible.has(ans)) {
            score += 2;
        }
    }

    return score;
};

function calculateCorrect(s) {
    const stack = [];
    let num = 0;
    let op = '+';

    for (let i = 0; i < s.length; i++) {
        const c = s[i];
        if (!isNaN(c)) {
            num = num * 10 + parseInt(c);
        }
        if (isNaN(c) || i === s.length - 1) {
            if (op === '+') {
                stack.push(num);
            } else if (op === '*') {
                stack.push(stack.pop() * num);
            }
            op = c;
            num = 0;
        }
    }

    return stack.reduce((a, b) => a + b, 0);
}