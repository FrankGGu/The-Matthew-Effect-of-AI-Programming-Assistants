function closetTarget(words, target, startIndex) {
    const n = words.length;
    let minDistance = Infinity;

    for (let i = 0; i < n; i++) {
        const index = (startIndex + i) % n;
        if (words[index] === target) {
            minDistance = Math.min(minDistance, i);
        }
        const reverseIndex = (startIndex - i + n) % n;
        if (words[reverseIndex] === target) {
            minDistance = Math.min(minDistance, i);
        }
    }

    return minDistance === Infinity ? -1 : minDistance;
}