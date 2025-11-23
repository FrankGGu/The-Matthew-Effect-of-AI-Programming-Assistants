class Solution {
public:
    int maxDepthAfterSplit(string seq) {
        int depth = 0, maxDepth = 0;
        for (char c : seq) {
            if (c == '(') {
                depth++;
                maxDepth = max(maxDepth, depth);
            } else {
                depth--;
            }
        }
        return (maxDepth + 1) / 2;
    }
};