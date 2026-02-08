#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findOccurrences(vector<int>& arr, int target) {
        vector<int> occurrences;
        for (int i = 0; i < arr.size(); ++i) {
            if (arr[i] == target) {
                occurrences.push_back(i);
            }
        }
        return occurrences;
    }
};