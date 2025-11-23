var calculateTax = function(brackets, income) {
    let tax = 0;
    let prevUpper = 0;

    for (const [upper, percent] of brackets) {
        if (income <= prevUpper) {
            break;
        }
        const taxable = Math.min(upper, income) - prevUpper;
        tax += taxable * percent / 100;
        prevUpper = upper;
    }

    return tax;
};