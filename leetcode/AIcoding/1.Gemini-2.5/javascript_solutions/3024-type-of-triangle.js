var triangleType = function(a, b, c) {
    if (a + b <= c || a + c <= b || b + c <= a) {
        return "Not a Triangle";
    }

    if (a === b && b === c) {
        return "Equilateral";
    } else if (a === b || a === c || b === c) {
        return "Isosceles";
    } else {
        return "Scalene";
    }
};