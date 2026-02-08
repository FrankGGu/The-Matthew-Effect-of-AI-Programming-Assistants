var maxSatisfaction = function(satisfaction) {
    satisfaction.sort((a, b) => a - b);
    let sum = 0;
    let res = 0;
    let total = 0;
    for (let i = satisfaction.length - 1; i >= 0; i--) {
        sum += satisfaction[i];
        if (sum > 0) {
            res += sum;
        } else {
            break;
        }
    }
    return res;
};