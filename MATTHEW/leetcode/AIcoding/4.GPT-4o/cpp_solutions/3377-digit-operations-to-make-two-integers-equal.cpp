class Solution {
public:
    int minOperations(int A, int B) {
        int diff = A ^ B, count = 0;
        while (diff) {
            count += diff & 1;
            diff >>= 1;
        }
        return count;
    }
};