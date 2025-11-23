var secondsToRemoveOccurrences = function(s) {
    let time = 0;
    let zeros = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '0') {
            zeros++;
        } else { // s[i] === '1'
            if (zeros > 0) {
                time = Math.max(time + 1, zeros);
                zeros--;
            } else if (time > 0) {
                time++;
            }
        }
    }

    return time;
};