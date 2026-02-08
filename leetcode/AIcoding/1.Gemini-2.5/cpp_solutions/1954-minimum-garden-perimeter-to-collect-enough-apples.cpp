class Solution {
public:
    long long minimumPerimeter(long long neededApples) {
        long long k = 0;
        long long currentApples = 0;
        while (currentApples < neededApples) {
            k++;
            currentApples += 12LL * k * k;
        }
        return 8 * k;
    }
};