function bestPosition(customers) {
    let x = 0, y = 0;
    for (const [cx, cy] of customers) {
        x += cx;
        y += cy;
    }
    const n = customers.length;
    return [Math.round(x / n), Math.round(y / n)];
}