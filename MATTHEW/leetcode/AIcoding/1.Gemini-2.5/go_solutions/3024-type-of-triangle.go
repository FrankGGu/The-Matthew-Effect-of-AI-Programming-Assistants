func triangleType(x int, y int, z int) string {
    // Check for invalid triangle conditions
    if x <= 0 || y <= 0 || z <= 0 {
        return "Invalid"
    }
    if x+y <= z || x+z <= y || y+z <= x {
        return "Invalid"
    }

    // Check for equilateral triangle
    if x == y && y == z {
        return "Equilateral"
    }

    // Check for isosceles triangle
    // At this point, we know it's a valid triangle and not equilateral.
    // If any two sides are equal, it's isosceles.
    if x == y || x == z || y == z {
        return "Isosceles"
    }

    // If none of the above, it must be a scalene triangle
    return "Scalene"
}