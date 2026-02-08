var bestClosingTime = function(customers) {
    let n = customers.length;
    let minPenalty = Infinity;
    let bestTime = 0;

    for (let i = 0; i <= n; i++) {
        let penalty = 0;
        for (let j = 0; j < i; j++) {
            if (customers[j] === 'N') {
                penalty++;
            }
        }
        for (let j = i; j < n; j++) {
            if (customers[j] === 'Y') {
                penalty++;
            }
        }

        if (penalty < minPenalty) {
            minPenalty = penalty;
            bestTime = i;
        }
    }

    return bestTime;
};