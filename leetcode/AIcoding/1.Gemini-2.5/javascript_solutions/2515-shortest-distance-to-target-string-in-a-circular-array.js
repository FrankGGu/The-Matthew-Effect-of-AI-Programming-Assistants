var shortestDistance = function(words, target, startIndex) {
    const n = words.length;
    let minSteps = Infinity;

    // Search forwards
    for (let i = 0; i < n; i++) {
        const currentIndex = (startIndex + i) % n;
        if (words[currentIndex] === target) {
            minSteps = Math.min(minSteps, i);
            break; 
        }
    }

    // Search backwards
    for (let i = 0; i < n; i++) {
        const currentIndex = (startIndex - i + n) % n;
        if (words[currentIndex] === target) {
            minSteps = Math.min(minSteps, i);
            break;
        }
    }

    return minSteps;
};