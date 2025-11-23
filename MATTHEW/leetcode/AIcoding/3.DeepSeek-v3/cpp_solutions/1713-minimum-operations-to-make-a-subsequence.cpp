class Solution {
public:
    int minOperations(vector<int>& target, vector<int>& arr) {
        unordered_map<int, int> pos;
        for (int i = 0; i < target.size(); ++i) {
            pos[target[i]] = i;
        }

        vector<int> stack;
        for (int num : arr) {
            if (pos.find(num) == pos.end()) continue;
            int idx = pos[num];
            if (stack.empty() || idx > stack.back()) {
                stack.push_back(idx);
            } else {
                auto it = lower_bound(stack.begin(), stack.end(), idx);
                *it = idx;
            }
        }

        return target.size() - stack.size();
    }
};