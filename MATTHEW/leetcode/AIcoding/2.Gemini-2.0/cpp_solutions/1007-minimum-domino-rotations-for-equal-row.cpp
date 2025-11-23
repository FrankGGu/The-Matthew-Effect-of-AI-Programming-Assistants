#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDominoRotations(vector<int>& tops, vector<int>& bottoms) {
        int n = tops.size();
        int rotations1 = findMinRotations(tops[0], tops, bottoms);
        int rotations2 = findMinRotations(bottoms[0], tops, bottoms);

        if (rotations1 == -1 && rotations2 == -1) {
            return -1;
        } else if (rotations1 == -1) {
            return rotations2;
        } else if (rotations2 == -1) {
            return rotations1;
        } else {
            return min(rotations1, rotations2);
        }
    }

private:
    int findMinRotations(int target, vector<int>& tops, vector<int>& bottoms) {
        int rotationsTopToBottom = 0;
        int rotationsBottomToTop = 0;

        bool possibleTopToBottom = true;
        bool possibleBottomToTop = true;

        for (int i = 0; i < tops.size(); ++i) {
            if (tops[i] != target && bottoms[i] != target) {
                return -1;
            }
        }

        for (int i = 0; i < tops.size(); ++i) {
            if (tops[i] != target) {
                rotationsTopToBottom++;
            }
        }
        return rotationsTopToBottom;
    }
};