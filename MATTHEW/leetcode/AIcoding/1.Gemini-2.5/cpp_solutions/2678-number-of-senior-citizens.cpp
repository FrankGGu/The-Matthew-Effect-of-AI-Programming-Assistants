class Solution {
public:
    int countSeniors(vector<string>& details) {
        int seniorCount = 0;
        for (const string& passenger : details) {
            int age = stoi(passenger.substr(11, 2));
            if (age > 60) {
                seniorCount++;
            }
        }
        return seniorCount;
    }
};