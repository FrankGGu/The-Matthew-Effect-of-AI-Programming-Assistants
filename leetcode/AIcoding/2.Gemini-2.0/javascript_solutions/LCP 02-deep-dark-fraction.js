var deepDarkFraction = function(cont) {
    let n = cont.length;
    let a = cont[n - 1];
    let b = 1;

    for (let i = n - 2; i >= 0; i--) {
        let temp = a;
        a = cont[i] * a + b;
        b = temp;
    }

    return [a, b];
};