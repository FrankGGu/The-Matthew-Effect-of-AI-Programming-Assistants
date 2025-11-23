#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestMultipleOfThree(vector<int>& digits) {
        vector<int> count(10);
        for (int d : digits) {
            count[d]++;
        }

        int totalMod = 0;
        for (int d : digits) {
            totalMod = (totalMod + d) % 3;
        }

        if (totalMod == 1) {
            if (!removeOne(count, 1) && !removeTwo(count, 2)) return "";
        } else if (totalMod == 2) {
            if (!removeOne(count, 2) && !removeTwo(count, 1)) return "";
        }

        string result = "";
        for (int i = 9; i >= 0; --i) {
            result += string(count[i], '0' + i);
        }

        return result.empty() || result[0] == '0' ? "0" : result;
    }

private:
    bool removeOne(vector<int>& count, int mod) {
        for (int i = mod; i < 10; i += 3) {
            if (count[i] > 0) {
                count[i]--;
                return true;
            }
        }
        return false;
    }

    bool removeTwo(vector<int>& count, int mod) {
        int removed = 0;
        for (int i = mod; i < 10; i += 3) {
            while (count[i] > 0 && removed < 2) {
                count[i]--;
                removed++;
            }
            if (removed == 2) return true;
        }
        return false;
    }
};