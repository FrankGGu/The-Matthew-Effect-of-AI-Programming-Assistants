function minRectangles(points) {
    const rectangles = new Set();

    for (const [x, y] of points) {
        const key = `${x},${y}`;
        if (!rectangles.has(key)) {
            rectangles.add(`${x},${y}`);
            for (let i = x + 1; i <= 1000; i++) {
                for (let j = y + 1; j <= 1000; j++) {
                    if (rectangles.has(`${i},${y}`) && rectangles.has(`${x},${j}`)) {
                        rectangles.delete(`${i},${y}`);
                        rectangles.delete(`${x},${j}`);
                    }
                }
            }
        }
    }

    return rectangles.size;
}