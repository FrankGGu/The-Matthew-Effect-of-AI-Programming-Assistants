const memo = new Map();
memo.set(1, 0);

function getPowerValue(n) {
    if (memo.has(n)) {
        return memo.get(n);
    }

    let power;
    if (n % 2 === 0) {
        power = 1 + getPowerValue(n / 2);
    } else {
        power = 1 + getPowerValue(3 * n + 1);
    }
    memo.set(n, power);
    return power;
}

var sortIntegersByPowerValue = function(lo, hi, k) {
    const numbers = [];
    for (let i = lo; i <= hi; i++) {
        numbers.push(i);
    }

    numbers.sort((a, b) => {
        const powerA = getPowerValue(a);
        const powerB = getPowerValue(b);

        if (powerA !== powerB) {
            return powerA - powerB;
        } else {
            return a - b;
        }
    });

    return numbers[k - 1];
};