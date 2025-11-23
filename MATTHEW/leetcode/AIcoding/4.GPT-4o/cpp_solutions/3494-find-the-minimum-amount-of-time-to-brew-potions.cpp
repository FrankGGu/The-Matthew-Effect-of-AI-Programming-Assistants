class Solution {
public:
    long long minTimeToBrew(vector<int>& time, vector<int>& total) {
        long long left = 1, right = 1e14;
        while (left < right) {
            long long mid = left + (right - left) / 2;
            long long brewed = 0;
            for (int i = 0; i < time.size(); i++) {
                brewed += mid / time[i];
            }
            if (brewed >= accumulate(total.begin(), total.end(), 0LL)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
};