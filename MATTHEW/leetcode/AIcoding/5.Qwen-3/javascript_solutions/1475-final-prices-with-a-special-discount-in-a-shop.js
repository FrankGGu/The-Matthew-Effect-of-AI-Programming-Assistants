function finalPrices(prices) {
    const stack = [];
    for (let i = 0; i < prices.length; i++) {
        while (stack.length > 0 && prices[stack[stack.length - 1]] >= prices[i]) {
            const j = stack.pop();
            prices[j] -= prices[i];
        }
        stack.push(i);
    }
    return prices;
}