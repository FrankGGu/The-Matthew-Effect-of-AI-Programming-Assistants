class Solution {
public:
    long long makeSubKSumEqual(vector<int>& arr, int k) {
        int n = arr.size();
        long long res = 0;
        vector<bool> visited(n, false);

        for (int i = 0; i < n; ++i) {
            if (visited[i]) continue;
            vector<int> group;
            int j = i;
            while (!visited[j]) {
                visited[j] = true;
                group.push_back(arr[j]);
                j = (j + k) % n;
            }
            sort(group.begin(), group.end());
            int median = group[group.size() / 2];
            for (int num : group) {
                res += abs(num - median);
            }
        }
        return res;
    }
};