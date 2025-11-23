class Solution {
public:
    bool asteroidsDestroyed(int mass, vector<int>& asteroids) {
        long long totalMass = mass;
        sort(asteroids.begin(), asteroids.end());

        for (int asteroid : asteroids) {
            if (totalMass < asteroid) return false;
            totalMass += asteroid;
        }

        return true;
    }
};