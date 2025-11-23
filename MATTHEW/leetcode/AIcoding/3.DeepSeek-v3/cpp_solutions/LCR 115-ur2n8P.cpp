class Solution {
public:
    bool sequenceReconstruction(vector<int>& org, vector<vector<int>>& seqs) {
        if (org.empty() || seqs.empty()) return false;
        int n = org.size();
        vector<int> pos(n + 1);
        for (int i = 0; i < n; ++i) {
            pos[org[i]] = i;
        }
        vector<bool> flags(n, false);
        int cnt = n - 1;
        bool isEmpty = true;
        for (auto& seq : seqs) {
            for (int i = 0; i < seq.size(); ++i) {
                isEmpty = false;
                if (seq[i] <= 0 || seq[i] > n) return false;
                if (i == 0) continue;
                int x = seq[i - 1], y = seq[i];
                if (pos[x] >= pos[y]) return false;
                if (flags[x] == false && pos[x] + 1 == pos[y]) {
                    flags[x] = true;
                    --cnt;
                }
            }
        }
        return cnt == 0 && !isEmpty;
    }
};