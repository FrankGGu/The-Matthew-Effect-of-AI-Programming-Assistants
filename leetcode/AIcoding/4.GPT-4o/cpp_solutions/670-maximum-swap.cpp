class Solution {
public:
    int maximumSwap(int num) {
        string strNum = to_string(num);
        vector<int> last(10, -1);
        for (int i = 0; i < strNum.size(); i++) {
            last[strNum[i] - '0'] = i;
        }

        for (int i = 0; i < strNum.size(); i++) {
            for (int d = 9; d > strNum[i] - '0'; d--) {
                if (last[d] > i) {
                    swap(strNum[i], strNum[last[d]]);
                    return stoi(strNum);
                }
            }
        }

        return num;
    }
};