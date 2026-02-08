class Solution {
public:
    string maximumBinaryString(string binary) {
        int count = 0;
        int n = binary.size();

        for (char c : binary) {
            if (c == '1') count++;
        }

        if (count == n) return string(n, '1');

        return string(count, '1') + '0' + string(n - count - 1, '1');
    }
};