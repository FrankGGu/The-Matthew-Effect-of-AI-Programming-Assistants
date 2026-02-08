class Solution {
public:
    int closetTarget(vector<string>& words, string target, int startIndex) {
        int n = words.size();
        if (find(words.begin(), words.end(), target) == words.end()) return -1;

        int leftDist = (startIndex - find(words.begin(), words.end(), target) - words.begin() + n) % n;
        int rightDist = (find(words.begin(), words.end(), target) - words.begin() - startIndex + n) % n;

        return min(leftDist, rightDist);
    }
};