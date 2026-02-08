class Solution {
public:
    int minimumBoxes(vector<int>& apple, vector<int>& capacity) {
        int totalApples = accumulate(apple.begin(), apple.end(), 0);
        sort(capacity.rbegin(), capacity.rend());
        int boxes = 0;
        int currentCapacity = 0;
        for (int cap : capacity) {
            currentCapacity += cap;
            boxes++;
            if (currentCapacity >= totalApples) {
                break;
            }
        }
        return boxes;
    }
};