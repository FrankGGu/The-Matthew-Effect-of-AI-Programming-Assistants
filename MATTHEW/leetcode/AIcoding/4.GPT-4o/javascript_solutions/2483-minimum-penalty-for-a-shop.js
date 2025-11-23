function bestClosingTime(customers) {
    let penalty = 0;
    let minPenalty = Infinity;
    let bestTime = 0;
    let n = customers.length;

    for (let i = 0; i < n; i++) {
        if (customers[i] === 'Y') penalty++;
    }

    for (let i = 0; i <= n; i++) {
        if (penalty < minPenalty) {
            minPenalty = penalty;
            bestTime = i;
        }
        if (i < n && customers[i] === 'Y') penalty--;
        else if (i < n && customers[i] === 'N') penalty++;
    }

    return bestTime;
}