function discountPrices(priceString) {
    const words = priceString.split(' ');
    const result = [];

    for (let word of words) {
        if (word.startsWith('$') && !isNaN(word.slice(1)) && word.slice(1).indexOf('.') === -1) {
            const num = parseFloat(word.slice(1));
            const discounted = num * 0.9;
            result.push(`$${discounted.toFixed(2)}`);
        } else {
            result.push(word);
        }
    }

    return result.join(' ');
}