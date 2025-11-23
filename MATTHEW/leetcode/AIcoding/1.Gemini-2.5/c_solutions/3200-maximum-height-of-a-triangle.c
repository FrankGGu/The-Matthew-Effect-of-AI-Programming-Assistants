#include <math.h>

static int check(long long h, int c1, int c2) {
    if (h == 0) {
        return 1;
    }
    long long num_odd_rows = (h + 1) / 2;
    long long num_even_rows = h / 2;

    long long needed_c1 = num_odd_rows * num_odd_rows;
    long long needed_c2 = num_even_rows * (num_even_rows + 1);

    return (needed_c1 <= c1 && needed_c2 <= c2);
}

static long long solve(int c1, int c2) {
    long long low = 0;
    long long high = 70000; 
    long long ans = 0;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (check(mid, c1, c2)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans;
}

int maxHeightOfTriangle(int red, int blue) {
    long long height1 = solve(red, blue);
    long long height2 = solve(blue, red);

    return (int)fmax(height1, height2);
}