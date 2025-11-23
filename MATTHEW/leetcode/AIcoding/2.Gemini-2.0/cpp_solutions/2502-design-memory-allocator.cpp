#include <vector>

using namespace std;

class Allocator {
public:
    Allocator(int n) : memory(n, 0) {}

    int allocate(int size, int mID) {
        for (int i = 0; i <= memory.size() - size; ++i) {
            bool found = true;
            for (int j = 0; j < size; ++j) {
                if (memory[i + j] != 0) {
                    found = false;
                    break;
                }
            }
            if (found) {
                for (int j = 0; j < size; ++j) {
                    memory[i + j] = mID;
                }
                return i;
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
        return count;
    }

private:
    vector<int> memory;
};