var scoreOfStudents = function(s, answers) {
    const n = s.length;
    const nums = [];
    const ops = [];
    for (let i = 0; i < n; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            nums.push(parseInt(s[i]));
        } else if (s[i] === '+' || s[i] === '*') {
            ops.push(s[i]);
        }
    }

    const calculateCorrectAnswer = () => {
        let result = nums[0];
        for (let i = 0; i < ops.length; i++) {
            if (ops[i] === '+') {
                result += nums[i + 1];
            } else {
                result *= nums[i + 1];
            }
        }
        return result;
    };

    const correctAnswer = calculateCorrectAnswer();

    const dp = Array(nums.length).fill(null).map(() => Array(nums.length).fill(null).map(() => new Set()));

    for (let i = 0; i < nums.length; i++) {
        dp[i][i].add(nums[i]);
    }

    for (let len = 2; len <= nums.length; len++) {
        for (let i = 0; i <= nums.length - len; i++) {
            let j = i + len - 1;
            for (let k = i; k < j; k++) {
                const leftSet = dp[i][k];
                const rightSet = dp[k + 1][j];
                const op = ops[k];

                for (const left of leftSet) {
                    for (const right of rightSet) {
                        let val = 0;
                        if (op === '+') {
                            val = left + right;
                        } else {
                            val = left * right;
                        }

                        if (val <= 1000) {
                            dp[i][j].add(val);
                        }
                    }
                }
            }
        }
    }

    let score = 0;
    for (const answer of answers) {
        if (answer === correctAnswer) {
            score += 5;
        } else if (dp[0][nums.length - 1].has(answer)) {
            score += 2;
        }
    }

    return score;
};