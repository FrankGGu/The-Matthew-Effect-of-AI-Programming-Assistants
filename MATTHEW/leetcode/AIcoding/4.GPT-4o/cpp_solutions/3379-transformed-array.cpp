class Solution {
public:
    vector<int> transformArray(vector<int>& arr) {
        vector<int> result = arr;
        bool changed = true;

        while (changed) {
            changed = false;
            vector<int> temp = result;
            for (int i = 1; i < arr.size() - 1; i++) {
                if (temp[i - 1] < temp[i] && temp[i] < temp[i + 1]) {
                    result[i]++;
                    changed = true;
                } else if (temp[i - 1] > temp[i] && temp[i] > temp[i + 1]) {
                    result[i]--;
                    changed = true;
                }
            }
        }

        return result;
    }
};