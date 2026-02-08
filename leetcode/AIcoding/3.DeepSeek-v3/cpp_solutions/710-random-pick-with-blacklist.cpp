class Solution {
private:
    unordered_map<int, int> m;
    int wlen;

public:
    Solution(int N, vector<int>& blacklist) {
        wlen = N - blacklist.size();
        unordered_set<int> bl;
        for (int b : blacklist) {
            if (b >= wlen) {
                bl.insert(b);
            }
        }
        int val = wlen;
        for (int b : blacklist) {
            if (b < wlen) {
                while (bl.count(val)) {
                    val++;
                }
                m[b] = val;
                val++;
            }
        }
    }

    int pick() {
        int k = rand() % wlen;
        if (m.count(k)) {
            return m[k];
        }
        return k;
    }
};