class Solution {
public:
    vector<int> mostVisited(int n, vector<int>& rounds) {
        vector<int> count(n + 1, 0);
        int m = rounds.size();
        for (int i = 1; i < m; ++i) {
            int start = rounds[i - 1];
            int end = rounds[i];
            while (start != end) {
                count[start]++;
                start++;
                if (start > n) start = 1;
            }
        }
        count[rounds.back()]++;
        int max_count = *max_element(count.begin(), count.end());
        vector<int> result;
        for (int i = 1; i <= n; ++i) {
            if (count[i] == max_count) {
                result.push_back(i);
            }
        }
        return result;
    }
};