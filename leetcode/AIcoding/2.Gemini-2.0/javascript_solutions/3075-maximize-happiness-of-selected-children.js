var maximizeHappiness = function(happiness, k) {
    happiness.sort((a, b) => b - a);
    let result = 0;
    for (let i = 0; i < k; i++) {
        result += happiness[i];
    }
    return result;
};