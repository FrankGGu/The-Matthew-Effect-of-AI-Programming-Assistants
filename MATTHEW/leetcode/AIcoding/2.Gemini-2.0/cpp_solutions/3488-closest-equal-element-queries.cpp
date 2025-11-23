class Solution {
public:
    vector<int> closestEqual(vector<int>& arr, vector<vector<int>>& queries) {
        int n = arr.size();
        vector<vector<int>> indices(100001);
        for (int i = 0; i < n; ++i) {
            indices[arr[i]].push_back(i);
        }

        vector<int> result;
        for (auto& query : queries) {
            int left = query[0];
            int right = query[1];
            int val = query[2];

            int minDiff = INT_MAX;
            int prev = -1;

            for (int index : indices[val]) {
                if (index >= left && index <= right) {
                    if (prev != -1) {
                        minDiff = min(minDiff, index - prev);
                    }
                    prev = index;
                }
            }

            if (minDiff == INT_MAX) {
                result.push_back(-1);
            } else {
                result.push_back(minDiff);
            }
        }

        return result;
    }
};