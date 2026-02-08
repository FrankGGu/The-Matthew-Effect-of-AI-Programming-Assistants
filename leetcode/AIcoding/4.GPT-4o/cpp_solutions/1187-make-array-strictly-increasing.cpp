class Solution {
public:
    int makeArrayIncreasing(vector<int>& arr1, vector<int>& arr2) {
        sort(arr2.begin(), arr2.end());
        set<int> possibleValues;
        possibleValues.insert(-1);
        int changes = 0;

        for (int num : arr1) {
            set<int> newPossibleValues;
            for (int prev : possibleValues) {
                if (num > prev) {
                    newPossibleValues.insert(num);
                }
                auto it = upper_bound(arr2.begin(), arr2.end(), prev);
                if (it != arr2.end()) {
                    newPossibleValues.insert(*it);
                }
            }
            possibleValues = newPossibleValues;
            if (possibleValues.empty()) return -1;
            changes++;
        }

        return changes - 1;
    }
};