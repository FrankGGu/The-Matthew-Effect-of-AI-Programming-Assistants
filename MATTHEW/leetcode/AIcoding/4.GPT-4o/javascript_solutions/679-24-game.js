var judgePoint24 = function(cards) {
    const target = 24;

    const operate = (a, b, op) => {
        switch (op) {
            case '+': return a + b;
            case '-': return a - b;
            case '*': return a * b;
            case '/': return b !== 0 ? a / b : null;
        }
    };

    const canAchieve = (numbers) => {
        if (numbers.length === 1) {
            return Math.abs(numbers[0] - target) < 1e-6;
        }

        for (let i = 0; i < numbers.length; i++) {
            for (let j = 0; j < numbers.length; j++) {
                if (i !== j) {
                    const nextNumbers = numbers.filter((_, index) => index !== i && index !== j);
                    for (const op of ['+', '-', '*', '/']) {
                        const result = operate(numbers[i], numbers[j], op);
                        if (result !== null) {
                            nextNumbers.push(result);
                            if (canAchieve(nextNumbers)) {
                                return true;
                            }
                            nextNumbers.pop();
                        }
                    }
                }
            }
        }

        return false;
    };

    return canAchieve(cards);
};