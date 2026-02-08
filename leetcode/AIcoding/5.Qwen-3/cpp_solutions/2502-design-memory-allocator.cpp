#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> memory;
    map<int, int> allocated;

    Solution(int n) {
        memory.resize(n, 0);
    }

    int allocate(int size, int mID) {
        int start = -1;
        for (int i = 0; i < memory.size(); ++i) {
            if (memory[i] == 0) {
                if (start == -1) {
                    start = i;
                }
                if (i - start + 1 == size) {
                    for (int j = start; j < start + size; ++j) {
                        memory[j] = mID;
                    }
                    allocated[mID] = start + size;
                    return start;
                }
            } else {
                start = -1;
            }
        }
        return -1;
    }

    int free(int mID) {
        int count = 0;
        for (int i = 0; i < memory.size(); ++i) {
            if (memory[i] == mID) {
                memory[i] = 0;
                count++;
            }
        }
        allocated.erase(mID);
        return count;
    }
};