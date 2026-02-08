var beautifulArray = function(N) {
    const result = [];

    const generate = (n) => {
        if (n === 1) return [1];
        const arr = generate(Math.ceil(n / 2));
        for (let x of arr) {
            result.push(x * 2 - 1);
        }
        for (let x of arr) {
            result.push(x * 2);
        }
        return result;
    };

    return generate(N);
};