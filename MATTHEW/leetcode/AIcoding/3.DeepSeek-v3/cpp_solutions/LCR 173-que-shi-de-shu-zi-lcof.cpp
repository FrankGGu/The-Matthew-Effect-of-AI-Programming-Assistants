class Solution {
public:
    int takeAttendance(vector<int>& records) {
        int left = 0, right = records.size() - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (records[mid] == mid) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }
};