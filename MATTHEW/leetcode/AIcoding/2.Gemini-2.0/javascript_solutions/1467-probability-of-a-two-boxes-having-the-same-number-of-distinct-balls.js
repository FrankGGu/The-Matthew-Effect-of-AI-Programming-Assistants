var getProbability = function(balls) {
    let n = balls.length;
    let totalBalls = balls.reduce((a, b) => a + b, 0);
    let half = totalBalls / 2;
    let count = 0;
    let total = 0;

    function combinations(arr, k) {
        if (k > arr.length || k <= 0) {
            return 0;
        }
        if (k === arr.length) {
            return 1;
        }
        if (k === 1) {
            return arr.length;
        }

        let memo = {};

        function helper(n, k) {
            let key = `${n}-${k}`;
            if (memo[key] !== undefined) {
                return memo[key];
            }

            if (k === 0) {
                memo[key] = 1;
                return 1;
            }
            if (n === k) {
                memo[key] = 1;
                return 1;
            }
            if (n < k) {
                memo[key] = 0;
                return 0;
            }

            memo[key] = helper(n - 1, k - 1) + helper(n - 1, k);
            return memo[key];
        }

        return helper(arr.length, k);
    }

    function multinominalCoefficient(arr) {
        let total = arr.reduce((a, b) => a + b, 0);
        let result = 1;

        let memo = {};

        function factorial(n) {
            if (memo[n] !== undefined) {
                return memo[n];
            }
            if (n === 0) {
                memo[n] = 1;
                return 1;
            }
            memo[n] = n * factorial(n - 1);
            return memo[n];
        }

        result = factorial(total);

        for (let i = 0; i < arr.length; i++) {
            result /= factorial(arr[i]);
        }

        return result;
    }

    function dfs(index, box1, box2, box1Distinct, box2Distinct) {
        if (index === n) {
            if (box1.reduce((a, b) => a + b, 0) === half) {
                total++;
                if (box1Distinct === box2Distinct) {
                    count++;
                }
            }
            return;
        }

        for (let i = 0; i <= balls[index]; i++) {
            box1.push(i);
            box2.push(balls[index] - i);
            let newBox1Distinct = box1[index] > 0 ? box1Distinct + 1 : box1Distinct;
            let newBox2Distinct = box2[index] > 0 ? box2Distinct + 1 : box2Distinct;
            dfs(index + 1, box1, box2, newBox1Distinct, newBox2Distinct);
            box1.pop();
            box2.pop();
        }
    }

    dfs(0, [], [], 0, 0);

    return count / total;
};