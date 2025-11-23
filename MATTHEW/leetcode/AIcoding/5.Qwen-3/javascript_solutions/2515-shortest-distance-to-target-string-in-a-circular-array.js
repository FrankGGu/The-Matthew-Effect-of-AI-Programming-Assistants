function closetTarget(targetArray, target, startIndex) {
    const n = targetArray.length;
    let minDistance = n;
    for (let i = 0; i < n; i++) {
        if (targetArray[i] === target) {
            let distance = Math.min(Math.abs(i - startIndex), n - Math.abs(i - startIndex));
            minDistance = Math.min(minDistance, distance);
        }
    }
    return minDistance;
}