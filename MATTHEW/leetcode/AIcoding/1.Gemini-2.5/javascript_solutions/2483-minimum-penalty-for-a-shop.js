var bestClosingTime = function(customers) {
    const n = customers.length;
    let minPenalty = 0;
    let currentPenalty = 0;
    let minHour = 0;

    // Calculate initial penalty for closing at hour 0
    // Penalty for j=0 is the count of 'Y's from index 0 to n-1
    for (let i = 0; i < n; i++) {
        if (customers[i] === 'Y') {
            currentPenalty++;
        }
    }

    minPenalty = currentPenalty;

    // Iterate through possible closing hours from 1 to n
    for (let j = 1; j <= n; j++) {
        // When moving from closing hour j-1 to j,
        // we consider the customer status at hour j-1.
        // If customers[j-1] was 'Y':
        // It was previously counted as a penalty (shop closed, customer arrived).
        // Now, shop is open at j-1, so this 'Y' no longer contributes to penalty.
        // Penalty decreases by 1.
        // If customers[j-1] was 'N':
        // It was previously not counted as a penalty (shop closed, no customer).
        // Now, shop is open at j-1, and no customer arrived, so this 'N' contributes to penalty.
        // Penalty increases by 1.
        if (customers[j - 1] === 'Y') {
            currentPenalty--;
        } else { // customers[j-1] === 'N'
            currentPenalty++;
        }

        // Update minimum penalty and corresponding hour
        if (currentPenalty < minPenalty) {
            minPenalty = currentPenalty;
            minHour = j;
        }
    }

    return minHour;
};