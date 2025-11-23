var maxDistance = function(colors) {
    let n = colors.length;
    let maxDist = 0;

    for (let i = 0; i < n; i++) {
        for (let j = n - 1; j > i; j--) {
            if (colors[i] !== colors[j]) {
                maxDist = Math.max(maxDist, j - i);
                break;
            }
        }
    }

    return maxDist;
};