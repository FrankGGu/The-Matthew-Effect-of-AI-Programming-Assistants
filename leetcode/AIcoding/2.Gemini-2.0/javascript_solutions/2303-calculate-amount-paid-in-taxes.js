var calculateTax = function(brackets, income) {
    let tax = 0;
    let prev = 0;
    for (let i = 0; i < brackets.length; i++) {
        let upper = brackets[i][0];
        let percent = brackets[i][1];
        let taxable = Math.min(income, upper) - prev;
        if (taxable > 0) {
            tax += taxable * percent / 100;
        } else {
            break;
        }
        prev = upper;
        if (income <= upper) {
            break;
        }
    }
    return tax;
};