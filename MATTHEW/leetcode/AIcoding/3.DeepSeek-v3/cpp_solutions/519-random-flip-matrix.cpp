class Solution {
private:
    int rows, cols, total;
    unordered_map<int, int> map;

public:
    Solution(int m, int n) {
        rows = m;
        cols = n;
        total = m * n;
    }

    vector<int> flip() {
        int r = rand() % total;
        total--;
        int x = map.count(r) ? map[r] : r;
        map[r] = map.count(total) ? map[total] : total;
        return {x / cols, x % cols};
    }

    void reset() {
        total = rows * cols;
        map.clear();
    }
};