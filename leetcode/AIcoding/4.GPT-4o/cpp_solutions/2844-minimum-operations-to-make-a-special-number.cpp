class Solution {
public:
    int minimumOperations(string num) {
        int n = num.size();
        int count = 0;
        bool hasOdd = false, hasEven = false;

        for (char c : num) {
            if ((c - '0') % 2 == 0) hasEven = true;
            else hasOdd = true;
        }

        if (hasOdd) count++;
        if (hasEven) count++;

        return count;
    }
};