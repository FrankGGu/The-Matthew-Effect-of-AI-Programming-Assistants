class Solution {
public:
    int waysToBuyPensPencils(int total, int cost1, int cost2) {
        int count = 0;
        for (int i = 0; i <= total; i += cost1) {
            count += (total - i) / cost2 + 1;
        }
        return count;
    }
};