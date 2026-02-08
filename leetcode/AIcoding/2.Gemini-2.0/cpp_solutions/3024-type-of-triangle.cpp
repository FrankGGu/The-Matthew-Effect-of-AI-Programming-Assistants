#include <algorithm>

using namespace std;

string triangleType(int a, int b, int c) {
    if (a + b <= c || a + c <= b || b + c <= a) {
        return "Not A Triangle";
    }
    if (a == b && b == c) {
        return "Equilateral";
    }
    if (a == b || a == c || b == c) {
        return "Isosceles";
    }
    return "Scalene";
}