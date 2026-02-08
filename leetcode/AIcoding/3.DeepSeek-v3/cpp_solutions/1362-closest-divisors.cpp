class Solution {
public:
    vector<int> closestDivisors(int num) {
        vector<int> res1 = findClosest(num + 1);
        vector<int> res2 = findClosest(num + 2);
        if (abs(res1[0] - res1[1]) < abs(res2[0] - res2[1])) {
            return res1;
        } else {
            return res2;
        }
    }

    vector<int> findClosest(int num) {
        for (int i = sqrt(num); i >= 1; --i) {
            if (num % i == 0) {
                return {i, num / i};
            }
        }
        return {};
    }
};