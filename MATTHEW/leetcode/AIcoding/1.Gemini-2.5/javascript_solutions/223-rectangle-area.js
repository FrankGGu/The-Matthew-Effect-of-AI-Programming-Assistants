var computeArea = function(ax1, ay1, ax2, ay2, bx1, by1, bx2, by2) {
    let area1 = (ax2 - ax1) * (ay2 - ay1);
    let area2 = (bx2 - bx1) * (by2 - by1);

    let overlapX1 = Math.max(ax1, bx1);
    let overlapY1 = Math.max(ay1, by1);
    let overlapX2 = Math.min(ax2, bx2);
    let overlapY2 = Math.min(ay2, by2);

    let overlapWidth = Math.max(0, overlapX2 - overlapX1);
    let overlapHeight = Math.max(0, overlapY2 - overlapY1);

    let overlapArea = overlapWidth * overlapHeight;

    return area1 + area2 - overlapArea;
};