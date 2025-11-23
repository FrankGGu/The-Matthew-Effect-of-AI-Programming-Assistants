function maxSatisfied(customers, grumpy, minutes) {
    let n = customers.length;
    let totalSatisfied = 0;
    let left = 0;
    let maxAdd = 0;
    let currentAdd = 0;

    for (let right = 0; right < n; right++) {
        if (!grumpy[right]) {
            totalSatisfied += customers[right];
        } else {
            currentAdd += customers[right];
        }

        while (right - left + 1 > minutes) {
            if (grumpy[left]) {
                currentAdd -= customers[left];
            }
            left++;
        }

        maxAdd = Math.max(maxAdd, currentAdd);
    }

    return totalSatisfied + maxAdd;
}