class Solution {
public:
    int maximizeSquareArea(int m, int n, vector<int>& hFences, vector<int>& vFences) {
        hFences.push_back(1);
        hFences.push_back(m);
        vFences.push_back(1);
        vFences.push_back(n);

        sort(hFences.begin(), hFences.end());
        sort(vFences.begin(), vFences.end());

        unordered_set<int> hDiffs;
        for (int i = 0; i < hFences.size(); ++i) {
            for (int j = i + 1; j < hFences.size(); ++j) {
                hDiffs.insert(hFences[j] - hFences[i]);
            }
        }

        int maxSide = -1;
        for (int i = 0; i < vFences.size(); ++i) {
            for (int j = i + 1; j < vFences.size(); ++j) {
                int diff = vFences[j] - vFences[i];
                if (hDiffs.count(diff)) {
                    maxSide = max(maxSide, diff);
                }
            }
        }

        return maxSide == -1 ? -1 : (long long)maxSide * maxSide % 1000000007;
    }
};