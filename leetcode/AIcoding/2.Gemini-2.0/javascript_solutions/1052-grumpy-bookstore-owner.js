var maxSatisfied = function(customers, grumpy, minutes) {
    let n = customers.length;
    let satisfied = 0;
    for (let i = 0; i < n; i++) {
        if (grumpy[i] === 0) {
            satisfied += customers[i];
        }
    }

    let maxExtra = 0;
    let currentExtra = 0;
    for (let i = 0; i < minutes; i++) {
        if (grumpy[i] === 1) {
            currentExtra += customers[i];
        }
    }
    maxExtra = currentExtra;

    for (let i = minutes; i < n; i++) {
        if (grumpy[i - minutes] === 1) {
            currentExtra -= customers[i - minutes];
        }
        if (grumpy[i] === 1) {
            currentExtra += customers[i];
        }
        maxExtra = Math.max(maxExtra, currentExtra);
    }

    return satisfied + maxExtra;
};