function calculateTax(brackets, income) {
    let tax = 0;
    let previousLimit = 0;

    for (let i = 0; i < brackets.length; i++) {
        const [limit, percent] = brackets[i];
        if (income > limit) {
            tax += (limit - previousLimit) * (percent / 100);
            previousLimit = limit;
        } else {
            tax += (income - previousLimit) * (percent / 100);
            break;
        }
    }

    return parseFloat(tax.toFixed(2));
}