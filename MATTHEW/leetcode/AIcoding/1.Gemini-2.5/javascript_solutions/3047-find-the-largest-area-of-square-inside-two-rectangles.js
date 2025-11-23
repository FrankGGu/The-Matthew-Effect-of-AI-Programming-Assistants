var largestSquareArea = function(rect1, rect2) {
    const x1_1 = rect1[0];
    const y1_1 = rect1[1];
    const x2_1 = rect1[2];
    const y2_1 = rect1[3];

    const x1_2 = rect2[0];
    const y1_2 = rect2[1];
    const x2_2 = rect2[2];
    const y2_2 = rect2[3];

    const intersect_x1 = Math.max(x1_1, x1_2);
    const intersect_y1 = Math.max(y1_1, y1_2);
    const intersect_x2 = Math.min(x2_1, x2_2);
    const intersect_y2 = Math.min(y2_1, y2_2);

    if (intersect_x1 >= intersect_x2 || intersect_y1 >= intersect_y2) {
        return 0;
    }

    const width = intersect_x2 - intersect_x1;
    const height = intersect_y2 - intersect_y1;

    const side = Math.min(width, height);

    return side * side;
};