class Solution {
public:
    int maxTeams(int n) {
        int k = 0;
        while (n >= k + 1) {
            n -= ++k;
        }
        return k;
    }
};