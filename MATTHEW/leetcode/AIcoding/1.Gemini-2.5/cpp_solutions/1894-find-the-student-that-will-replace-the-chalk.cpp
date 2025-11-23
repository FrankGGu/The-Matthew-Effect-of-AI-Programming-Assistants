class Solution {
public:
    int chalkReplacer(std::vector<int>& chalk, int k) {
        long long totalChalkNeededPerCycle = 0;
        for (int c : chalk) {
            totalChalkNeededPerCycle += c;
        }

        long long remainingK = k % totalChalkNeededPerCycle;

        for (int i = 0; i < chalk.size(); ++i) {
            if (remainingK < chalk[i]) {
                return i;
            }
            remainingK -= chalk[i];
        }

        return -1; // Should not be reached based on problem constraints
    }
};