class Solution {
public:
    vector<int> transformArray(vector<int>& arr) {
        bool changed;
        do {
            changed = false;
            vector<int> newArr = arr;
            for (int i = 1; i < arr.size() - 1; ++i) {
                if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
                    newArr[i]--;
                    changed = true;
                } else if (arr[i] < arr[i - 1] && arr[i] < arr[i + 1]) {
                    newArr[i]++;
                    changed = true;
                }
            }
            arr = newArr;
        } while (changed);
        return arr;
    }
};