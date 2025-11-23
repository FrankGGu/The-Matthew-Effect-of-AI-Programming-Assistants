class Solution {
public:
    long long numberOfSubarrays(vector<int>& nums) {
        long long res = 0;
        stack<pair<int, int>> st; // {num, count}

        for (int num : nums) {
            while (!st.empty() && st.top().first < num) {
                st.pop();
            }
            if (!st.empty() && st.top().first == num) {
                st.top().second++;
            } else {
                st.push({num, 1});
            }
            res += st.top().second;
        }

        return res;
    }
};