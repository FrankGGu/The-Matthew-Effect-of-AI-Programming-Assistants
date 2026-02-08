function monkeyCollision(polygon) {
    let count = 0;
    for (let i = 0; i < polygon.length; i++) {
        if (polygon[i] === 'L' && polygon[(i + 1) % polygon.length] === 'R') {
            count += 2; // both monkeys collide
        } else if (polygon[i] === 'R' && polygon[(i + 1) % polygon.length] === 'L') {
            count++; // only one monkey collides
        }
    }
    return count;
}