function trainingPlan(fit1, fit2) {
    let result = [];
    let i = 0, j = 0;
    while (i < fit1.length && j < fit2.length) {
        if (fit1[i] < fit2[j]) {
            result.push(fit1[i]);
            i++;
        } else {
            result.push(fit2[j]);
            j++;
        }
    }
    while (i < fit1.length) {
        result.push(fit1[i]);
        i++;
    }
    while (j < fit2.length) {
        result.push(fit2[j]);
        j++;
    }
    return result;
}