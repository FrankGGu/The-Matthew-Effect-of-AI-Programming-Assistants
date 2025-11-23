class Solution {
public:
    int waysToBuyPensPencils(int total, int cost1, int cost2) {
        int count = 0;
        for (int i = 0; i <= total / cost1; ++i) {
            count += (total - i * cost1) / cost2 + 1;
        }
        return count;
    }
};