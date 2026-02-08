class Solution {
    public String triangleType(int x, int y, int z) {
        if (!((long)x + y > z && (long)x + z > y && (long)y + z > x)) {
            return "None";
        }

        if (x == y && y == z) {
            return "Equilateral";
        } else if (x == y || x == z || y == z) {
            return "Isosceles";
        } else {
            return "Scalene";
        }
    }
}