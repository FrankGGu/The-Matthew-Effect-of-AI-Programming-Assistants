function getLastMoment(n, left, right) {
    let maxLeft = 0;
    let minRight = n;

    for (let ant of left) {
        if (ant > maxLeft) {
            maxLeft = ant;
        }
    }

    for (let ant of right) {
        if (ant < minRight) {
            minRight = ant;
        }
    }

    return Math.max(maxLeft, n - minRight);
}