class Solution {
public:
    bool isPossible(int n) {
        return n % 2 == 0 || n % 3 == 0;
    }
};