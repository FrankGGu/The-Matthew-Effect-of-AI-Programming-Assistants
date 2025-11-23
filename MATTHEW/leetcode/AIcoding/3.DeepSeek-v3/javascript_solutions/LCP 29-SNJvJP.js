var orchestraLayout = function(num, xPos, yPos) {
    let layer = Math.min(xPos, yPos, num - 1 - xPos, num - 1 - yPos);
    let total = 0;
    let n = num;
    for (let i = 0; i < layer; i++) {
        total += 4 * (n - 1);
        n -= 2;
    }
    let side = num - 2 * layer;
    let start = total % 9 + 1;
    let offset;
    if (xPos === layer) {
        offset = yPos - layer + 1;
    } else if (yPos === num - 1 - layer) {
        offset = (side - 1) + (xPos - layer) + 1;
    } else if (xPos === num - 1 - layer) {
        offset = 2 * (side - 1) + (num - 1 - layer - yPos) + 1;
    } else {
        offset = 3 * (side - 1) + (num - 1 - layer - xPos) + 1;
    }
    return (start + offset - 1) % 9 === 0 ? 9 : (start + offset - 1) % 9;
};