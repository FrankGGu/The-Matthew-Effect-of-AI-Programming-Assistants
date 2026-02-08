class Solution {
public:
    int compress(vector<char>& chars) {
        int n = chars.size();
        int write = 0, count = 0;

        for (int read = 0; read < n; read++) {
            count++;
            if (read + 1 == n || chars[read] != chars[read + 1]) {
                chars[write++] = chars[read];
                if (count > 1) {
                    string countStr = to_string(count);
                    for (char c : countStr) {
                        chars[write++] = c;
                    }
                }
                count = 0;
            }
        }

        return write;
    }
};