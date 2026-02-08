var minimumChairs = function(s) {
    let maxChairs = 0;
    let currentChairs = 0;
    for (let char of s) {
        if (char === 'E') {
            currentChairs++;
            maxChairs = Math.max(maxChairs, currentChairs);
        } else {
            currentChairs--;
        }
    }
    return maxChairs;
};