var isPossible = function(typed, target) {
    let i = 0, j = 0;
    const m = typed.length, n = target.length;

    while (i < m && j < n) {
        if (typed[i] === target[j]) {
            i++;
            j++;
        } else {
            if (i > 0 && typed[i] === typed[i - 1]) {
                i++;
            } else {
                return false;
            }
        }
    }

    while (i < m) {
        if (typed[i] === typed[i - 1]) {
            i++;
        } else {
            return false;
        }
    }

    return j === n;
};