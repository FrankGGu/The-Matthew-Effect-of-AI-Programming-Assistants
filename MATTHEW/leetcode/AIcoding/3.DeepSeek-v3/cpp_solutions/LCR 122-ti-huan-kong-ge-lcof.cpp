class Solution {
public:
    string pathEncryption(string path) {
        int count = 0;
        for (char c : path) {
            if (c == ' ') {
                count++;
            }
        }
        int oldLen = path.size();
        int newLen = oldLen + count * 2;
        path.resize(newLen);
        int i = oldLen - 1, j = newLen - 1;
        while (i >= 0) {
            if (path[i] == ' ') {
                path[j--] = '0';
                path[j--] = '2';
                path[j--] = '%';
            } else {
                path[j--] = path[i];
            }
            i--;
        }
        return path;
    }
};