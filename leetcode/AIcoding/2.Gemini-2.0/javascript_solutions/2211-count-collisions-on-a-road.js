var countCollisions = function(directions) {
    let collisions = 0;
    let left = 0;
    let right = directions.length - 1;

    while (left < right && directions[left] === 'L') {
        left++;
    }

    while (right > left && directions[right] === 'R') {
        right--;
    }

    for (let i = left; i <= right; i++) {
        if (directions[i] === 'R') {
            collisions++;
        } else if (directions[i] === 'L') {
            collisions++;
        }
    }

    return collisions;
};