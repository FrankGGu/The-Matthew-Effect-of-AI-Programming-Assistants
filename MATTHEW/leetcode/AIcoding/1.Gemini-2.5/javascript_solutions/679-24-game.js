var judgePoint24 = function(nums) {
    const EPSILON = 1e-6;

    function solve(list) {
        if (list.length === 0) {
            return false;
        }
        if (list.length === 1) {
            return Math.abs(list[0] - 24) < EPSILON;
        }

        for (let i = 0; i < list.length; i++) {
            for (let j = i + 1; j < list.length; j++) {
                const num1 = list[i];
                const num2 = list[j];

                const nextList = [];
                for (let k = 0; k < list.length; k++) {
                    if (k !== i && k !== j) {
                        nextList.push(list[k]);
                    }
                }

                // Addition
                nextList.push(num1 + num2);
                if (solve(nextList)) return true;
                nextList.pop();

                // Subtraction (num1 - num2)
                nextList.push(num1 - num2);
                if (solve(nextList)) return true;
                nextList.pop();

                // Subtraction (num2 - num1)
                nextList.push(num2 - num1);
                if (solve(nextList)) return true;
                nextList.pop();

                // Multiplication
                nextList.push(num1 * num2);
                if (solve(nextList)) return true;
                nextList.pop();

                // Division (num1 / num2)
                if (Math.abs(num2) > EPSILON) {
                    nextList.push(num1 / num2);
                    if (solve(nextList)) return true;
                    nextList.pop();
                }

                // Division (num2 / num1)
                if (Math.abs(num1) > EPSILON) {
                    nextList.push(num2 / num1);
                    if (solve(nextList)) return true;
                    nextList.pop();
                }
            }
        }
        return false;
    }

    return solve(nums);
};