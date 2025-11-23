class Solution {
public:
    int findLucky(vector<int>& arr) {
        unordered_map<int, int> count;
        for (int num : arr) {
            count[num]++;
        }
        int lucky = -1;
        for (auto& entry : count) {
            if (entry.first == entry.second) {
                lucky = max(lucky, entry.first);
            }
        }
        return lucky;
    }
};