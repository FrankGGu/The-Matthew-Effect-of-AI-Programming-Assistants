function maxSatisfaction(satisfaction) {
    satisfaction.sort((a, b) => a - b);
    let total = 0;
    let result = 0;
    for (let i = satisfaction.length - 1; i >= 0; i--) {
        total += satisfaction[i];
        if (total > 0) {
            result += total;
        } else {
            break;
        }
    }
    return result;
}