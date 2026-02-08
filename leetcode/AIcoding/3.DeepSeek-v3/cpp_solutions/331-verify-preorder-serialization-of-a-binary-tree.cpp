class Solution {
public:
    bool isValidSerialization(string preorder) {
        int slots = 1;
        int n = preorder.size();
        for (int i = 0; i < n; ++i) {
            if (slots == 0) {
                return false;
            }
            if (preorder[i] == ',') {
                continue;
            }
            if (preorder[i] == '#') {
                slots--;
                i++;
            } else {
                while (i < n && preorder[i] != ',') {
                    i++;
                }
                slots++;
            }
        }
        return slots == 0;
    }
};