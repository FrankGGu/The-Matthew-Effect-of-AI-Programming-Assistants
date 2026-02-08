class Solution {
public:
    string findOriginalString(string typed) {
        string original;
        int n = typed.size();
        for (int i = 0; i < n; ) {
            original += typed[i];
            int j = i + 1;
            while (j < n && typed[j] == typed[i]) {
                j++;
            }
            i = j;
        }
        return original;
    }
};