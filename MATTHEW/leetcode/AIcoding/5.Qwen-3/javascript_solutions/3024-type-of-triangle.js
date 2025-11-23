function triangleType(x, y, z) {
    if (x + y <= z || x + z <= y || y + z <= x) {
        return "Neither";
    }
    if (x === y && y === z) {
        return "Equilateral";
    } else if (x === y || y === z || x === z) {
        return "Isosceles";
    } else {
        return "Scalene";
    }
}