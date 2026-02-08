class Solution {
public:
    int minWastedSpace(vector<int>& sizes, vector<vector<int>>& boxes) {
        sort(sizes.begin(), sizes.end());
        long long total = 0;
        for (int size : sizes) total += size;

        int n = sizes.size();
        long long ans = LLONG_MAX;

        for (auto& box : boxes) {
            if (box.size() < n) continue;
            sort(box.begin(), box.end());
            long long waste = 0;
            int j = 0;

            for (int b : box) {
                int count = 0;
                while (j < n && sizes[j] <= b) {
                    count++;
                    j++;
                }
                waste += count * b;  
                if (count > 0) waste -= total;
            }
            ans = min(ans, waste);
        }

        return ans == LLONG_MAX ? 0 : ans;
    }
};