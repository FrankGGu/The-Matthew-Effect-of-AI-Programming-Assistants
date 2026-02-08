class Solution {
public:
    int Rand10() {
        int num = 40; // 7 * 7 - 7
        while (num >= 40) {
            num = (Rand7() - 1) * 7 + (Rand7() - 1);
        }
        return num % 10 + 1;
    }
};