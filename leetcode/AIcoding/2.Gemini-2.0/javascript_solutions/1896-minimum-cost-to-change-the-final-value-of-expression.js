var minOperationsToFlip = function(expression) {
    function calculate(s) {
        const ops = [];
        const nums = [];

        function evalTop() {
            const op = ops.pop();
            const num2 = nums.pop();
            const num1 = nums.pop();
            if (op === '&') {
                nums.push([Math.min(num1[0] + num2[0], Math.min(num1[0] + num2[1], num1[1] + num2[0])), num1[1] + num2[1]]);
            } else {
                nums.push([num1[0] + num2[0], Math.min(num1[1] + num2[1], Math.min(num1[1] + num2[0], num1[0] + num2[1]))]);
            }
        }

        for (let i = 0; i < s.length; i++) {
            const c = s[i];
            if (c === '(') {
                ops.push(c);
            } else if (c === ')') {
                while (ops[ops.length - 1] !== '(') {
                    evalTop();
                }
                ops.pop();
            } else if (c === '&' || c === '|') {
                while (ops.length > 0 && ops[ops.length - 1] !== '(') {
                    evalTop();
                }
                ops.push(c);
            } else {
                nums.push([c === '0' ? 0 : 1, c === '1' ? 0 : 1]);
            }
        }

        while (ops.length > 0) {
            evalTop();
        }

        return nums[0];
    }

    const result = calculate(expression);
    return Math.min(result[0], result[1]);
};