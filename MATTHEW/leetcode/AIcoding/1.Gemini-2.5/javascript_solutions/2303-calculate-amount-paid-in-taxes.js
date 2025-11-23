var calculateTax = function(brackets, income) {
    let totalTax = 0;
    let prevUpper = 0;

    for (let i = 0; i < brackets.length; i++) {
        const [currentUpper, percent] = brackets[i];

        const taxableAmountInThisSlice = Math.min(income, currentUpper) - prevUpper;

        if (taxableAmountInThisSlice > 0) {
            totalTax += taxableAmountInThisSlice * (percent / 100);
        }

        prevUpper = currentUpper;

        if (income <= currentUpper) {
            break; 
        }
    }

    return totalTax;
};