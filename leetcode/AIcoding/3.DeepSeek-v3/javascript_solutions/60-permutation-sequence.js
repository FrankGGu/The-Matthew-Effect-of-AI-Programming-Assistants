var getPermutation = function(n, k) {
    let numbers = [];
    let factorial = [1];
    let result = '';

    for (let i = 1; i <= n; i++) {
        numbers.push(i);
        factorial[i] = factorial[i - 1] * i;
    }

    k--;

    for (let i = 1; i <= n; i++) {
        let index = Math.floor(k / factorial[n - i]);
        result += numbers[index];
        numbers.splice(index, 1);
        k -= index * factorial[n - i];
    }

    return result;
};