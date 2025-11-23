class Solution {
public:
    long long repairCars(vector<int>& ranks, int cars) {
        long long left = 1, right = 1e14, result = 0;
        while (left <= right) {
            long long mid = left + (right - left) / 2;
            long long total = 0;
            for (int rank : ranks) {
                total += sqrt(mid / rank);
            }
            if (total >= cars) {
                result = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return result;
    }
};