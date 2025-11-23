var maxHappinessSum = function(happiness, k) {
    happiness.sort((a, b) => b - a);

    let totalHappiness = 0;

    for (let i = 0; i < k; i++) {
        const currentHappiness = happiness[i] - i;
        if (currentHappiness > 0) {
            totalHappiness += currentHappiness;
        } else {
            break; 
        }
    }

    return totalHappiness;
};