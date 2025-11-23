class Solution {
public:
    bool isPossible(vector<int>& target) {
        long total = 0;
        priority_queue<long> maxHeap;
        for (int num : target) {
            total += num;
            maxHeap.push(num);
        }

        while (true) {
            long largest = maxHeap.top();
            maxHeap.pop();
            total -= largest;

            if (largest == 1 || total == 1) return true;
            if (largest < total || total == 0 || largest % total == 0) return false;

            largest %= total;
            total += largest;
            maxHeap.push(largest);
        }
    }
};