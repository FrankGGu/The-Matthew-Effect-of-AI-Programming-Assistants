class Solution {
public:
    bool isTransformable(string s, string t) {
        int n = s.size();
        vector<int> pos[10];
        for (int i = 0; i < n; i++) {
            pos[s[i] - '0'].push_back(i);
        }

        for (int i = 0; i < n; i++) {
            int digit = t[i] - '0';
            if (pos[digit].empty()) return false;
            int index = pos[digit].back();
            pos[digit].pop_back();
            for (int j = 0; j < digit; j++) {
                if (!pos[j].empty() && pos[j].back() > index) return false;
            }
        }
        return true;
    }
};