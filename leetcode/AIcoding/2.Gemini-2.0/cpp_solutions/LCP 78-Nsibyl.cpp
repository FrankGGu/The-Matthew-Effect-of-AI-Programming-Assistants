#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long defendFort(vector<int>& forts) {
        long long max_len = 0;
        int last_occupied = -1;
        for (int i = 0; i < forts.size(); ++i) {
            if (forts[i] != 0) {
                if (last_occupied != -1 && forts[i] != forts[last_occupied]) {
                    long long current_len = 0;
                    for (int j = last_occupied + 1; j < i; ++j) {
                        if (forts[j] == 0) {
                            current_len++;
                        } else {
                            current_len = 0;
                            break;
                        }
                    }
                    max_len = max(max_len, current_len);
                }
                last_occupied = i;
            }
        }
        return max_len;
    }
};