function checkOverlap(circle, rectangle) {
    const [circleX, circleY, radius] = circle;
    const [rectX, rectY, rectWidth, rectHeight] = rectangle;

    let closestX = Math.max(rectX, Math.min(circleX, rectX + rectWidth));
    let closestY = Math.max(rectY, Math.min(circleY, rectY + rectHeight));

    const dx = circleX - closestX;
    const dy = circleY - closestY;

    return dx * dx + dy * dy < radius * radius;
}