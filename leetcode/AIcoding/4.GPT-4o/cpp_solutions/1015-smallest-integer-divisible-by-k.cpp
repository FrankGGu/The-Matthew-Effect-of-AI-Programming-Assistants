class Solution {
public:
    int smallestRepunitDivByK(int K) {
        if (K % 2 == 0 || K % 5 == 0) return -1;
        int length = 1, num = 1 % K;
        while (num != 0) {
            num = (num * 10 + 1) % K;
            length++;
        }
        return length;
    }
};