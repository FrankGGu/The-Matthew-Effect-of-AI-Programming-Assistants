var maxDistance = function(position, m) {
    position.sort((a, b) => a - b);

    const check = (force) => {
        let count = 1;
        let lastPosition = position[0];
        for (let i = 1; i < position.length; i++) {
            if (position[i] - lastPosition >= force) {
                count++;
                lastPosition = position[i];
            }
            if (count === m) {
                return true;
            }
        }
        return false;
    };

    let low = 1;
    let high = position[position.length - 1] - position[0];
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor((low + high) / 2);
        if (check(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};