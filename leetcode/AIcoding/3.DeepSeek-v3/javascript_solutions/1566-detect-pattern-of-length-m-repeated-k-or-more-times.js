var containsPattern = function(arr, m, k) {
    for (let i = 0; i <= arr.length - m * k; i++) {
        let pattern = arr.slice(i, i + m).join('');
        let valid = true;
        for (let j = 1; j < k; j++) {
            let nextPattern = arr.slice(i + j * m, i + (j + 1) * m).join('');
            if (nextPattern !== pattern) {
                valid = false;
                break;
            }
        }
        if (valid) {
            return true;
        }
    }
    return false;
};