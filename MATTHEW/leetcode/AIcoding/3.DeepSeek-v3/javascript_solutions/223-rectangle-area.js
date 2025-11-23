var computeArea = function(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2) {
    const areaA = (ax2 - ax1) * (ay2 - ay1);
    const areaB = (bx2 - bx1) * (by2 - by1);

    const overlapWidth = Math.min(ax2, bx2) - Math.max(ax1, bx1);
    const overlapHeight = Math.min(ay2, by2) - Math.max(ay1, by1);
    const overlapArea = Math.max(overlapWidth, 0) * Math.max(overlapHeight, 0);

    return areaA + areaB - overlapArea;
};