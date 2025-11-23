class Solution {
public:
    int maxCampTime(vector<int>& camps) {
        int n = camps.size();
        sort(camps.begin(), camps.end());
        int total = 0;
        for (int i = 0; i < n; ++i) {
            total += camps[i];
        }
        return total - camps[n - 1];
    }
};