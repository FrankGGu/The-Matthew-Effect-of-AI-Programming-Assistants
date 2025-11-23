function maxDistance(position, m) {
    position.sort((a, b) => a - b);

    let left = 1, right = position[position.length - 1] - position[0];
    let result = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        let count = 1;
        let lastPosition = position[0];

        for (let i = 1; i < position.length; i++) {
            if (position[i] - lastPosition >= mid) {
                count++;
                lastPosition = position[i];
            }
        }

        if (count >= m) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}