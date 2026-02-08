class Solution {
public:
    int minCapitalGain(vector<vector<int>>& projects, int initialCapital, int numProjects) {
        priority_queue<int> maxHeap;
        sort(projects.begin(), projects.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] < b[0];
        });

        int i = 0;
        for (int j = 0; j < numProjects; ++j) {
            while (i < projects.size() && projects[i][0] <= initialCapital) {
                maxHeap.push(projects[i][1]);
                i++;
            }
            if (maxHeap.empty()) break;
            initialCapital += maxHeap.top();
            maxHeap.pop();
        }

        return initialCapital;
    }
};