class Solution {
public:
    int numFriendRequests(vector<int>& ages) {
        int count = 0;
        vector<int> ageCount(121, 0);

        for (int age : ages) {
            ageCount[age]++;
        }

        for (int i = 1; i <= 120; ++i) {
            if (ageCount[i] == 0) continue;
            for (int j = 1; j <= 120; ++j) {
                if (ageCount[j] == 0) continue;
                if (j <= 0.5 * i + 7) continue;
                if (j > i) continue;
                if (i == j) {
                    count += ageCount[i] * (ageCount[i] - 1);
                } else {
                    count += ageCount[i] * ageCount[j];
                }
            }
        }

        return count;
    }
};