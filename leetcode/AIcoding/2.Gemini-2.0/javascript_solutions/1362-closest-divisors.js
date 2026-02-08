var closestDivisors = function(num) {
    let a = num + 1;
    let b = num + 2;
    let resA = [];
    let resB = [];
    let minDiff = Infinity;

    for (let i = Math.floor(Math.sqrt(a)); i >= 1; i--) {
        if (a % i === 0) {
            resA = [i, a / i];
            if (Math.abs(i - (a / i)) < minDiff) {
                minDiff = Math.abs(i - (a / i));
            }
            break;
        }
    }

    for (let i = Math.floor(Math.sqrt(b)); i >= 1; i--) {
        if (b % i === 0) {
            resB = [i, b / i];
             if (Math.abs(i - (b / i)) < minDiff) {
                minDiff = Math.abs(i - (b / i));
                return [i, b / i];
            }
            break;
        }
    }

    return resA;
};