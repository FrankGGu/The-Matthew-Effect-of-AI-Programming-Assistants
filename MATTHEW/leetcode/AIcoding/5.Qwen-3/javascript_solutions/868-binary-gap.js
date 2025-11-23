function binaryGap(n) {
    let maxDistance = 0;
    let lastPosition = -1;
    let position = 0;

    while (n > 0) {
        if (n % 2 === 1) {
            if (lastPosition !== -1) {
                maxDistance = Math.max(maxDistance, position - lastPosition);
            }
            lastPosition = position;
        }
        n = Math.floor(n / 2);
        position++;
    }

    return maxDistance;
}