var maxDistance = function(position, m) {
    position.sort((a, b) => a - b);
    let left = 1;
    let right = position[position.length - 1] - position[0];
    let ans = 0;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let count = 1;
        let lastPos = position[0];

        for (let i = 1; i < position.length; i++) {
            if (position[i] - lastPos >= mid) {
                count++;
                lastPos = position[i];
            }
        }

        if (count >= m) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
};