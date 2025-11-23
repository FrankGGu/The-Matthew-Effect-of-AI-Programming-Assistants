char * triangleType(int x, int y, int z) {
    if (x + y <= z || x + z <= y || y + z <= x) {
        return "none";
    } else if (x == y && y == z) {
        return "equilateral";
    } else if (x == y || y == z || x == z) {
        return "isosceles";
    } else {
        return "scalene";
    }
}