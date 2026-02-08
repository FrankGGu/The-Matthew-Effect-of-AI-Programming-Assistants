class Solution {
public:
    vector<string> findRestaurant(vector<string>& list1, vector<string>& list2) {
        unordered_map<string, int> map;
        for (int i = 0; i < list1.size(); ++i) {
            map[list1[i]] = i;
        }

        vector<string> result;
        int minSum = INT_MAX;

        for (int j = 0; j < list2.size(); ++j) {
            if (map.find(list2[j]) != map.end()) {
                int sum = j + map[list2[j]];
                if (sum < minSum) {
                    result.clear();
                    result.push_back(list2[j]);
                    minSum = sum;
                } else if (sum == minSum) {
                    result.push_back(list2[j]);
                }
            }
        }

        return result;
    }
};