var isSelfCrossing = function(distance) {
    const n = distance.length;

    if (n <= 3) {
        return false;
    }

    for (let i = 3; i < n; ++i) {
        // Case 1: The i-th line crosses the (i-3)-th line
        // (e.g., current segment `distance[i]` crosses `distance[i-2]`)
        // This is when the path turns inward and the current segment is long enough
        // to cross an earlier, parallel segment.
        if (distance[i] >= distance[i-2] && distance[i-1] <= distance[i-3]) {
            return true;
        }

        // Case 2: The i-th line crosses the (i-4)-th line
        // This happens when the path forms a "closed square" or "rectangle"
        // and the current segment `distance[i]` crosses `distance[i-4]`.
        // This requires at least 5 segments (i.e., i >= 4)
        if (i >= 4) {
            if (distance[i-1] == distance[i-3] && distance[i] + distance[i-4] >= distance[i-2]) {
                return true;
            }
        }

        // Case 3: The i-th line crosses the (i-5)-th line
        // This is the most general "inward spiral" crossing.
        // This requires at least 6 segments (i.e., i >= 5)
        if (i >= 5) {
            if (distance[i-2] >= distance[i-4] && distance[i-1] >= distance[i-3] - distance[i-5] && distance[i] + distance[i-4] >= distance[i-2]) {
                return true;
            }
        }
    }

    return false;
};