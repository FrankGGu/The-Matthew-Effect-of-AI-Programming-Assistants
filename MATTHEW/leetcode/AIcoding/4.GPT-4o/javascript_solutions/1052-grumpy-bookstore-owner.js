var maxSatisfied = function(customers, grumpy, X) {
    let totalSatisfied = 0, maxExtraSatisfied = 0, currentExtraSatisfied = 0;

    for (let i = 0; i < customers.length; i++) {
        if (grumpy[i] === 0) {
            totalSatisfied += customers[i];
        } else {
            currentExtraSatisfied += customers[i];
        }

        if (i >= X) {
            if (grumpy[i - X] === 1) {
                currentExtraSatisfied -= customers[i - X];
            }
        }

        if (i >= X - 1) {
            maxExtraSatisfied = Math.max(maxExtraSatisfied, currentExtraSatisfied);
        }
    }

    return totalSatisfied + maxExtraSatisfied;
};