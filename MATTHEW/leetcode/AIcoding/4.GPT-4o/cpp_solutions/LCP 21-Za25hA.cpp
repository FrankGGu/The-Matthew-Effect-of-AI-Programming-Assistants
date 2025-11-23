class Solution {
public:
    string chaseGame(vector<int>& a, vector<int>& b) {
        int n = a.size();
        int m = b.size();
        int maxA = *max_element(a.begin(), a.end());
        int maxB = *max_element(b.begin(), b.end());

        if (maxA < maxB) return "B";
        if (maxA > maxB) return "A";
        return "Draw";
    }
};