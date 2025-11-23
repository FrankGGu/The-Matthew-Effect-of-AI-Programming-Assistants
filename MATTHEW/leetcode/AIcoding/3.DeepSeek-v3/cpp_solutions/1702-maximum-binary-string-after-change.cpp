class Solution {
public:
    string maximumBinaryString(string binary) {
        int n = binary.size();
        int zeros = 0;
        int first_zero_pos = -1;

        for (int i = 0; i < n; ++i) {
            if (binary[i] == '0') {
                zeros++;
                if (first_zero_pos == -1) {
                    first_zero_pos = i;
                }
            }
        }

        if (zeros <= 1) {
            return binary;
        }

        string res(n, '1');
        res[first_zero_pos + zeros - 1] = '0';
        return res;
    }
};