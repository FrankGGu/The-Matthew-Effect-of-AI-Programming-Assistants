var maxSatisfied = function(customers, grumpy, minutes) {
    let satisfied = 0;
    let maxExtra = 0;
    let currentExtra = 0;

    for (let i = 0; i < customers.length; i++) {
        if (grumpy[i] === 0) {
            satisfied += customers[i];
        } else {
            currentExtra += customers[i];
        }

        if (i >= minutes && grumpy[i - minutes] === 1) {
            currentExtra -= customers[i - minutes];
        }

        if (currentExtra > maxExtra) {
            maxExtra = currentExtra;
        }
    }

    return satisfied + maxExtra;
};