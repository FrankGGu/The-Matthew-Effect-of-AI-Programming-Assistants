using namespace std;

class Solution {
public:
    int lastStoneWeight(vector<int>& stones) {
        priority_queue<int> max_heap;
        for (int stone : stones) {
            max_heap.push(stone);
        }

        while (max_heap.size() > 1) {
            int y = max_heap.top();
            max_heap.pop();
            int x = max_heap.top();
            max_heap.pop();

            if (x != y) {
                max_heap.push(y - x);
            }
        }

        return max_heap.empty() ? 0 : max_heap.top();
    }
};