class Solution {
public:
    bool doesValidArrayExist(vector<int>& derived) {
        int n = derived.size();
        int original = 0;
        for (int i = 0; i < n - 1; ++i) {
            original ^= derived[i];
        }
        if ((original ^ 0) == derived.back()) {
            return true;
        }
        original = 1;
        for (int i = 0; i < n - 1; ++i) {
            original ^= derived[i];
        }
        if ((original ^ 1) == derived.back()) {
            return true;
        }
        return false;
    }
};