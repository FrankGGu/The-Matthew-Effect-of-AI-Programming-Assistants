class Solution {
public:
    int minTimeToRevert(string s) {
        int n = s.size();
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }
        int maxCount = *max_element(count.begin(), count.end());
        return n - maxCount;
    }
};