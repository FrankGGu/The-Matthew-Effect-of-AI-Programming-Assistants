class Solution {
public:
    int minimumEnergy(vector<vector<int>>& tasks) {
        int totalEnergy = 0;
        int currentEnergy = 0;

        for (const auto& task : tasks) {
            int requiredEnergy = task[0];
            int actualEnergy = task[1];

            if (currentEnergy < requiredEnergy) {
                totalEnergy += requiredEnergy - currentEnergy;
                currentEnergy = requiredEnergy;
            }
            currentEnergy -= actualEnergy;
        }

        return totalEnergy;
    }
};