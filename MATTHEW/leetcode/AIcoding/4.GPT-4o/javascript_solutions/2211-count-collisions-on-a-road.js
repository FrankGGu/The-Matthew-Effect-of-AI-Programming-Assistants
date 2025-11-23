var countCollisions = function(directions) {
    let collisions = 0;
    let i = 0;
    const n = directions.length;

    while (i < n) {
        if (directions[i] === 'S') {
            i++;
            continue;
        }
        let start = i;
        while (i < n && directions[i] !== 'S') {
            i++;
        }
        if (directions[start] === 'L' || (i < n && directions[i] === 'R')) {
            collisions += (i - start);
        }
    }

    return collisions;
};