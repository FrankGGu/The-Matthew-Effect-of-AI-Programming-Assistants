var shortestDistance = function(words, target, startIndex) {
    let minDistance = Infinity;
    for (let i = 0; i < words.length; i++) {
        if (words[i] === target) {
            let distance = Math.min(Math.abs(i - startIndex), words.length - Math.abs(i - startIndex));
            minDistance = Math.min(minDistance, distance);
        }
    }
    return minDistance;
};