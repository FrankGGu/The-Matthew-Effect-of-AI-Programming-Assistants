#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    int minimumTimeToFinishAllJobs(vector<int>& jobs, vector<int>& workers) {
        sort(jobs.begin(), jobs.end());
        sort(workers.begin(), workers.end());
        int result = 0;
        for (int i = 0; i < jobs.size(); ++i) {
            result = max(result, jobs[i] + workers[i]);
        }
        return result;
    }
};