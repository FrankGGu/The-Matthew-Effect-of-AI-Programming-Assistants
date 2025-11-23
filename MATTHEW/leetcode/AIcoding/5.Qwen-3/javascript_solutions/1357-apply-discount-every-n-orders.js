function discountRates(orders, n, discount) {
    const result = [];
    let count = 0;
    for (const order of orders) {
        count++;
        if (count % n === 0) {
            result.push(order * (1 - discount / 100));
        } else {
            result.push(order);
        }
    }
    return result;
}