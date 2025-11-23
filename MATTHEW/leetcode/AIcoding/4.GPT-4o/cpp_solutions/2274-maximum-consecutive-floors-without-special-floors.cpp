class Solution {
public:
    int maxConsecutive(int bottom, int top, vector<int>& special) {
        sort(special.begin(), special.end());
        int max_consecutive = 0;

        if (special.empty()) {
            return top - bottom + 1;
        }

        max_consecutive = max(max_consecutive, special[0] - bottom);
        for (int i = 1; i < special.size(); i++) {
            max_consecutive = max(max_consecutive, special[i] - special[i - 1] - 1);
        }
        max_consecutive = max(max_consecutive, top - special.back());

        return max_consecutive;
    }
};