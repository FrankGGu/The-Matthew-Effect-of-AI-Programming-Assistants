class Solution {
public:
    int findLargestElementAfterMerges(vector<int>& arr) {
        sort(arr.begin(), arr.end());
        while (arr.size() > 1) {
            int newElement = arr[0] + arr[1];
            arr.erase(arr.begin());
            arr.erase(arr.begin());
            arr.push_back(newElement);
            sort(arr.begin(), arr.end());
        }
        return arr[0];
    }
};