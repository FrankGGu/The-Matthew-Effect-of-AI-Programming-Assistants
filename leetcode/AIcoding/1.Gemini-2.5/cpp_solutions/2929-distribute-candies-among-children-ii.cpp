class Solution {
public:
    long long distributeCandies(int n, int limit) {
        auto count_ways = [](long long k) -> long long {
            if (k < 0) {
                return 0;
            }
            return (k + 2) * (k + 1) / 2;
        };

        long long total_ways = count_ways(n);
        long long ways_one_exceeds = count_ways(n - (limit + 1));
        long long ways_two_exceeds = count_ways(n - 2 * (limit + 1));
        long long ways_three_exceeds = count_ways(n - 3 * (limit + 1));

        return total_ways - 3 * ways_one_exceeds + 3 * ways_two_exceeds - ways_three_exceeds;
    }
};