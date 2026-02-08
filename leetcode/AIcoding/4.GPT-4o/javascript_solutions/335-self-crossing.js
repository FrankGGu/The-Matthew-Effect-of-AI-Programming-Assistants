var isSelfCrossing = function(distance) {
    let n = distance.length;
    for (let i = 3; i < n; i++) {
        // Fourth line crosses first line
        if (distance[i] >= distance[i - 2] && distance[i - 1] <= distance[i - 3]) {
            return true;
        }
        // Fifth line meets first line
        if (i >= 4 && distance[i - 1] === distance[i - 3] && distance[i] + distance[i - 4] >= distance[i - 2]) {
            return true;
        }
        // Sixth line crosses first line
        if (i >= 5 && distance[i - 2] >= distance[i - 4] && distance[i] + distance[i - 4] >= distance[i - 2] && distance[i - 1] + distance[i - 3] >= distance[i - 1]) {
            return true;
        }
    }
    return false;
};