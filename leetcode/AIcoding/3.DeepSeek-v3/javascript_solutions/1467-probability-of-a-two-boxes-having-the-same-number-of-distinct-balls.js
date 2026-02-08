var getProbability = function(balls) {
    const n = balls.length;
    const total = balls.reduce((a, b) => a + b, 0);
    const half = total / 2;

    const factorial = (num) => {
        let res = 1;
        for (let i = 2; i <= num; i++) {
            res *= i;
        }
        return res;
    };

    const totalPermutations = balls.reduce((acc, val) => acc / factorial(val), factorial(total));

    let valid = 0;

    const backtrack = (index, count1, count2, distinct1, distinct2, permutations1, permutations2) => {
        if (count1 > half || count2 > half) return;
        if (index === n) {
            if (count1 === count2 && distinct1 === distinct2) {
                valid += permutations1 * permutations2;
            }
            return;
        }

        const ball = balls[index];
        for (let i = 0; i <= ball; i++) {
            const newCount1 = count1 + i;
            const newCount2 = count2 + (ball - i);
            const newDistinct1 = distinct1 + (i > 0 ? 1 : 0);
            const newDistinct2 = distinct2 + (ball - i > 0 ? 1 : 0);
            const newPermutations1 = permutations1 / factorial(i);
            const newPermutations2 = permutations2 / factorial(ball - i);
            backtrack(
                index + 1,
                newCount1,
                newCount2,
                newDistinct1,
                newDistinct2,
                newPermutations1,
                newPermutations2
            );
        }
    };

    backtrack(0, 0, 0, 0, 0, factorial(total), factorial(total));

    return valid / totalPermutations;
};