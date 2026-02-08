var computeArea = function(A, B, C, D, E, F, G, H) {
    let area1 = (C - A) * (D - B);
    let area2 = (G - E) * (H - F);
    let overlapWidth = Math.max(0, Math.min(C, G) - Math.max(A, E));
    let overlapHeight = Math.max(0, Math.min(D, H) - Math.max(B, F));
    let overlapArea = overlapWidth * overlapHeight;
    return area1 + area2 - overlapArea;
};