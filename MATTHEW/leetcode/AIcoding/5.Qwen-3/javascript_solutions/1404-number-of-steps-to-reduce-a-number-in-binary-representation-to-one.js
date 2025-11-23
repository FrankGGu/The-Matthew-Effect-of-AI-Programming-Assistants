var numSteps = function(s) {
    let steps = 0;
    let n = s.length;
    let i = n - 1;

    while (i > 0) {
        if (s[i] === '1') {
            steps++;
            i--;
            while (i >= 0 && s[i] === '1') {
                steps++;
                i--;
            }
            if (i >= 0) {
                steps++;
            }
        } else {
            steps++;
        }
        i--;
    }

    return steps;
};