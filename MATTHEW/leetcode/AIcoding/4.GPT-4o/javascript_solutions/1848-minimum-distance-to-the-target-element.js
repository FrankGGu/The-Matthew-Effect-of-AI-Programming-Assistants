var closestTarget = function(words, target, startIndex) {
    let n = words.length;
    let closest = Infinity;

    for (let i = 0; i < n; i++) {
        if (words[i] === target) {
            closest = Math.min(closest, Math.abs(i - startIndex), n - Math.abs(i - startIndex));
        }
    }

    return closest === Infinity ? -1 : closest;
};