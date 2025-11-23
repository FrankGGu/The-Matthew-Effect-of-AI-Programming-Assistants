package main

func checkOverlap(radius int, xCenter1 int, yCenter1 int, xCenter2 int, yCenter2 int, xCorner2 int, yCorner2 int) bool {
    // Find the closest point on the rectangle to the circle's center
    xClosest := xCenter1
    if xCenter1 < xCorner2 {
        xClosest = xCorner2
    } else if xCenter1 > xCorner2+1 {
        xClosest = xCorner2 + 1
    }

    yClosest := yCenter1
    if yCenter1 < yCorner2 {
        yClosest = yCorner2
    } else if yCenter1 > yCorner2+1 {
        yClosest = yCorner2 + 1
    }

    // Calculate the distance squared between the circle's center and the closest point
    dx := xCenter1 - xClosest
    dy := yCenter1 - yClosest
    distanceSquared := dx*dx + dy*dy

    return distanceSquared <= radius*radius
}