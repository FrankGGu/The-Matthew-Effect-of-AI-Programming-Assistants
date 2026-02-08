class Solution {
public:
    bool stoneGameIX(vector<int>& stones) {
        int cnt0 = 0, cnt1 = 0, cnt2 = 0;
        for (int stone : stones) {
            if (stone % 3 == 0) {
                cnt0++;
            } else if (stone % 3 == 1) {
                cnt1++;
            } else {
                cnt2++;
            }
        }

        if (cnt1 == 0 && cnt2 == 0) return false;

        if (cnt1 > cnt2) {
            if (cnt0 % 2 == 0) return true;
            else return (cnt1 - cnt2) > 2;
        } else {
            if (cnt0 % 2 == 0) return true;
            else return (cnt2 - cnt1) > 2;
        }
    }
};