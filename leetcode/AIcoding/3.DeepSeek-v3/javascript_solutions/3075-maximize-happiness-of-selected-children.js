var maximumHappinessSum = function(happiness, k) {
    happiness.sort((a, b) => b - a);
    let sum = 0;
    for (let i = 0; i < k; i++) {
        if (happiness[i] - i > 0) {
            sum += happiness[i] - i;
        }
    }
    return sum;
};