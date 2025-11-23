function maxDistance(position, m) {
    position.sort((a, b) => a - b);

    function canPlaceBalls(d) {
        let count = 1;
        let last = position[0];

        for (let i = 1; i < position.length; i++) {
            if (position[i] - last >= d) {
                count++;
                last = position[i];
                if (count === m) return true;
            }
        }

        return count >= m;
    }

    let left = 1;
    let right = position[position.length - 1] - position[0];
    let result = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        if (canPlaceBalls(mid)) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}