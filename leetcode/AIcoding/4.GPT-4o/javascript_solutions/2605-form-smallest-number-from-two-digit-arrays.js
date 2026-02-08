var minNumber = function(A, B) {
    let minA = Math.min(...A);
    let minB = Math.min(...B);
    let result = Math.min(minA, minB);

    for (let a of A) {
        for (let b of B) {
            let num1 = a * 10 + b;
            let num2 = b * 10 + a;
            result = Math.min(result, num1, num2);
        }
    }

    return result.toString();
};