function minMovesToCaptureTheQueen(x, y, px, py) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1]];
    for (let [dx, dy] of directions) {
        let nx = x + dx;
        let ny = y + dy;
        let blocked = false;
        while (nx >= 0 && ny >= 0 && nx < 8 && ny < 8) {
            if (nx === px && ny === py) {
                blocked = true;
                break;
            }
            nx += dx;
            ny += dy;
        }
        if (!blocked) return 1;
    }
    return 2;
}