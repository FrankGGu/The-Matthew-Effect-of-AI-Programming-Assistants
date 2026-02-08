class Solution {
public:
    int numOfWays(int n) {
        long long two_colors = 6;
        long long three_colors = 6;
        int mod = 1e9 + 7;

        for (int i = 1; i < n; ++i) {
            long long new_two_colors = (two_colors * 3 + three_colors * 2) % mod;
            long long new_three_colors = (two_colors * 2 + three_colors * 2) % mod;
            two_colors = new_two_colors;
            three_colors = new_three_colors;
        }

        return (two_colors + three_colors) % mod;
    }
};