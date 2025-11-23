class Solution {
public:
    vector<int> asteroidCollision(vector<int>& asteroids) {
        vector<int> res;
        for (int a : asteroids) {
            while (!res.empty() && res.back() > 0 && a < 0) {
                int sum = res.back() + a;
                if (sum < 0) {
                    res.pop_back();
                } else if (sum > 0) {
                    a = 0;
                } else {
                    res.pop_back();
                    a = 0;
                }
            }
            if (a != 0) {
                res.push_back(a);
            }
        }
        return res;
    }
};