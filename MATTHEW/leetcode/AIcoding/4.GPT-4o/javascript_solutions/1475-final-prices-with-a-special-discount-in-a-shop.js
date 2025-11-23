function finalPrices(prices) {
    const n = prices.length;
    const result = new Array(n).fill(0);
    const stack = [];

    for (let i = 0; i < n; i++) {
        while (stack.length && prices[stack[stack.length - 1]] >= prices[i]) {
            const index = stack.pop();
            result[index] = prices[index] - prices[i];
        }
        stack.push(i);
    }

    while (stack.length) {
        result[stack.pop()] = prices[result[stack[stack.length - 1]]];
    }

    return result;
}