var clumsy = function(N) {
    let result = 0;
    let sign = 1;

    for (let i = N; i > 0; i -= 1) {
        if (i === N) {
            result += sign * i * (i - 1) / (i - 2);
            i -= 2;
        } else {
            result += sign * i;
        }
        sign *= -1;
    }

    return result;
};