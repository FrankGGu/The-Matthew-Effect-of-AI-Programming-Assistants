class Solution {
public:
    bool stoneGameIX(vector<int>& stones) {
        int cnt1 = 0, cnt2 = 0;
        for (int stone : stones) {
            if (stone % 3 == 1) {
                cnt1++;
            } else if (stone % 3 == 2) {
                cnt2++;
            }
        }
        int cnt0 = stones.size() - cnt1 - cnt2;
        if (cnt1 == 0 && cnt2 == 0) {
            return false;
        }
        if (cnt0 % 2 == 0) {
            return abs(cnt1 - cnt2) > 2;
        } else {
            return cnt1 > 0 && cnt2 > 0;
        }
    }
};