class Solution {
public:
    int garbageCollection(vector<string>& garbage, vector<int>& travel) {
        int totalTime = 0, lastG = 0, lastP = 0, lastM = 0;

        for (int i = 0; i < garbage.size(); i++) {
            totalTime += garbage[i].size();
            if (garbage[i].find('G') != string::npos) lastG = i;
            if (garbage[i].find('P') != string::npos) lastP = i;
            if (garbage[i].find('M') != string::npos) lastM = i;
        }

        for (int i = 0; i < lastG; i++) totalTime += travel[i];
        for (int i = 0; i < lastP; i++) totalTime += travel[i];
        for (int i = 0; i < lastM; i++) totalTime += travel[i];

        return totalTime;
    }
};