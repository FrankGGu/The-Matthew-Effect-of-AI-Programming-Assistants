class Solution {
public:
    long long minimumPerimeter(long long neededApples) {
        long long n = 1;
        long long totalApples = 0;
        while (totalApples < neededApples) {
            totalApples += 6 * n;
            n++;
        }
        return 8 * (n - 1);
    }
};