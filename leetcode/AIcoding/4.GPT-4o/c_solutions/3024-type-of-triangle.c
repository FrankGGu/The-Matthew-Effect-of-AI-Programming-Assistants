int triangleType(int a, int b, int c) {
    if (a <= 0 || b <= 0 || c <= 0) return 0; // not a triangle
    if (a + b <= c || a + c <= b || b + c <= a) return 0; // not a triangle
    if (a == b && b == c) return 1; // equilateral
    if (a == b || b == c || a == c) return 2; // isosceles
    return 3; // scalene
}