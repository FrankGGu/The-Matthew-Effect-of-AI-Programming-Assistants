class Solution {
public:
    int maxTaskAssign(vector<int>& tasks, vector<int>& workers, int pills, int strength) {
        sort(tasks.begin(), tasks.end());
        sort(workers.begin(), workers.end());

        int left = 0, right = min(tasks.size(), workers.size());
        int answer = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            bool possible = check(tasks, workers, pills, strength, mid);
            if (possible) {
                answer = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return answer;
    }

private:
    bool check(vector<int>& tasks, vector<int>& workers, int pills, int strength, int k) {
        if (k == 0) return true;
        if (workers.size() < k) return false;

        multiset<int> workerSet(workers.end() - k, workers.end());

        for (int i = k - 1; i >= 0; --i) {
            auto it = workerSet.lower_bound(tasks[i]);
            if (it != workerSet.end()) {
                workerSet.erase(it);
            } else {
                if (pills == 0) return false;
                it = workerSet.lower_bound(tasks[i] - strength);
                if (it == workerSet.end()) return false;
                workerSet.erase(it);
                --pills;
            }
        }

        return true;
    }
};