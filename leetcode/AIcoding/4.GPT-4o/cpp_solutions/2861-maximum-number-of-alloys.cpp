class Solution {
public:
    int maxAlloys(int N, vector<int>& alloys) {
        int low = 1, high = *max_element(alloys.begin(), alloys.end()), answer = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canProduceAlloys(alloys, mid, N)) {
                answer = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return answer;
    }

    bool canProduceAlloys(vector<int>& alloys, int target, int N) {
        long long total = 0;
        for (int alloy : alloys) {
            total += alloy / target;
            if (total >= N) return true;
        }
        return total >= N;
    }
};