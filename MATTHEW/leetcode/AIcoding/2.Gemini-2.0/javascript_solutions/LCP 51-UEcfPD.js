var maxSatisfaction = function(satisfaction) {
    satisfaction.sort((a, b) => a - b);
    let n = satisfaction.length;
    let ans = 0;
    let sum = 0;
    let cur = 0;
    for (let i = n - 1; i >= 0; i--) {
        sum += satisfaction[i];
        if (sum > 0) {
            cur += sum;
            ans = Math.max(ans, cur);
        } else {
            break;
        }
    }
    return ans;
};