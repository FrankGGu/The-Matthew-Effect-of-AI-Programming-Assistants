class Solution {
public:
    int addEdges(vector<int>& edges) {
        int n = edges.size();
        int oddCount = 0;

        for (int degree : edges) {
            if (degree % 2 != 0) {
                oddCount++;
            }
        }

        return (oddCount + 1) / 2;
    }
};